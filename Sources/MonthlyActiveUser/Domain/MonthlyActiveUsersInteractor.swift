//
//  MonthlyActiveUsersInteractor.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import Foundation

class MonthlyActiveUsersInteractor {
    
    private let store: MonthlyActiveUsersStoreProtocol
    
    enum Error: Swift.Error {
        case unableToCalculateStartDate
        case dataError
        case invalidData
    }
    
    init(store: MonthlyActiveUsersStoreProtocol) {
        self.store = store
    }
    
    fileprivate func firstDayOfLastMonth() -> Date? {
        let calendar = Calendar.current
        
        // Get the current date
        let currentDate = Date()
        
        // Get the start of the current month
        if let startOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)) {
            
            // Subtract one month to get the start of the last month
            let components = DateComponents(month: -1)
            if let startOfLastMonth = calendar.date(byAdding: components, to: startOfCurrentMonth) {
                return startOfLastMonth
            }
        }

        return nil
    }
}

extension MonthlyActiveUsersInteractor: MonthlyActiveUsersInteractorProtocol {
    
    public func monthlyActiveUsers() async throws -> ActiveUsers {
        guard let firstDayOfLastMonth = firstDayOfLastMonth() else {
            throw Error.unableToCalculateStartDate
        }
        let now = Date()

        do {
            return try await store.getCurrentMonthsActiveUsers(startDate: firstDayOfLastMonth, endDate: now)
        } catch {
            print("Error: \(error)")
            throw Error.dataError
        }
    }
}
