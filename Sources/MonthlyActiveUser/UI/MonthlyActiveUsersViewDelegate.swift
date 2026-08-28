//
//  MonthlyActiveUsersViewDelegate.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

@MainActor
public protocol MonthlyActiveUsersViewDelegate: AnyObject {
    func didRequestRefresh()
}
