//
//  MonthlyActiveUsersViewModel.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import Combine

@MainActor
public class MonthlyActiveUsersViewModel: ObservableObject {

    @Published public var activeUsers: String
    @Published public var sinceDate: String
    @Published public var deltaLastMonth: String
    
    init(
        activeUsers: String,
        sinceDate: String,
        deltaLastMonth: String
    ) {
        self.activeUsers = activeUsers
        self.sinceDate = sinceDate
        self.deltaLastMonth = deltaLastMonth
    }
}
