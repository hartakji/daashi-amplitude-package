//
//  MonthlyActiveUsersView.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import SwiftUI

public struct MonthlyActiveUsersView: View {
    
    @ObservedObject
    public var viewModel: MonthlyActiveUsersViewModel
    private var delegate: MonthlyActiveUsersViewDelegate?
    
    public init(
        viewModel: MonthlyActiveUsersViewModel,
        delegate: MonthlyActiveUsersViewDelegate? = nil
    ) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    public var body: some View {
        Button {
            delegate?.didRequestRefresh()
        } label: {
            VStack(spacing: 0) {
                VStack(spacing: 3) {
                    Text("")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 12))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(viewModel.activeUsers)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 25))
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(viewModel.deltaLastMonth)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 12))
                        .bold()
                        .multilineTextAlignment(.center)
                }
                .frame(maxHeight: .infinity)
                VStack(spacing: 0) {
                    Text(viewModel.sinceDate)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 10))
                        .bold()
                        .multilineTextAlignment(.center)
                }.frame(maxHeight: 19)
            }
        }
    }
}

import WidgetFoundation
#Preview {
    VStack {
        MonthlyActiveUsersView(
            viewModel: MonthlyActiveUsersViewModel(
                activeUsers: "19",
                sinceDate: "Active users 01/07",
                deltaLastMonth: "+30% (15)"
            )
        )
        .toWidget()
    }
}

