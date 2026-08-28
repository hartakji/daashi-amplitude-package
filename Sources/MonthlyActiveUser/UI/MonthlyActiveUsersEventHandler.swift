//
//  MonthlyActiveUsersEventHandler.swift
//  CurrencyWidget
//
//  Created by Jean DAHER on 27/08/2026.
//

import Foundation
import WidgetFoundation

@MainActor
class MonthlyActiveUsersEventHandler {
    
    var viewModel: MonthlyActiveUsersViewModel
    var interactor: MonthlyActiveUsersInteractorProtocol
    var config: MonthlyActiveUsersConfig
        
    required init(
        config: MonthlyActiveUsersConfig,
        viewModel: MonthlyActiveUsersViewModel,
        interactor: MonthlyActiveUsersInteractorProtocol
    ) {
        self.config = config
        self.viewModel = viewModel
        self.interactor = interactor
    }
    
    var activeUserSince: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    @MainActor
    func setViewModel(_ activeUsers: ActiveUsers) {
        self.viewModel.activeUsers = "\(activeUsers.currentMonth)"
        let deltaLastMonth = activeUsers.currentMonth - activeUsers.lastMonth
        let deltaInPercentage = String(format: "%1.0f", 100*(Float(deltaLastMonth)/Float(activeUsers.lastMonth)))
        if deltaLastMonth < 0 {
            self.viewModel.deltaLastMonth = "\(deltaInPercentage)% (\(activeUsers.lastMonth))"
        } else if deltaLastMonth > 0 {
            self.viewModel.deltaLastMonth = "+\(deltaInPercentage)% (\(activeUsers.lastMonth))"
        } else {
            self.viewModel.deltaLastMonth = "=\(deltaInPercentage)% (\(activeUsers.lastMonth))"
        }
        
        let formatedSinceDate = activeUserSince.string(from: activeUsers.currentMonthStartDate)
        self.viewModel.sinceDate = "Since \(formatedSinceDate)"
    }
    
    @MainActor
    func performAsyncTask() async {
        Task { [weak self] in
            guard let self else { return }
            do {
                let activeUsers = try await interactor.monthlyActiveUsers()
                setViewModel(activeUsers)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func startFifteenMinuteLoop() {
        Task {
            await performAsyncTask()
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(60*Double(config.refreshInterval)))
                guard !Task.isCancelled else { break }
                await performAsyncTask()
            }
        }
    }
}

extension MonthlyActiveUsersEventHandler: MonthlyActiveUsersViewDelegate {
    
    func didRequestRefresh() {
        // TODO: or not
    }
}

extension MonthlyActiveUsersEventHandler: WidgetEventHandlerProtocol {
    
    func onLoad() {
        startFifteenMinuteLoop()
    }
    
    @MainActor
    func onUnload() {
        
    }
}
