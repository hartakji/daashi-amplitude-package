//
//  MonthlyActiveUsersInteractorProtocol.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import Foundation

protocol MonthlyActiveUsersInteractorProtocol {
    func monthlyActiveUsers() async throws -> ActiveUsers
}
