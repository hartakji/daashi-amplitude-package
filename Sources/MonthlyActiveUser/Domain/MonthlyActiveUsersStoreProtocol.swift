//
//  MonthlyActiveUsersStoreProtocol.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import Foundation

protocol MonthlyActiveUsersStoreProtocol {
    func getCurrentMonthsActiveUsers(startDate: Date, endDate: Date) async throws -> ActiveUsers
}
