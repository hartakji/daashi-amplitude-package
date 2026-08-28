//
//  MonthlyActiveUsersConfig.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import WidgetFoundation

public struct MonthlyActiveUsersConfig: WidgetConfigPayload {
    public static let componentIdentifier = "daashi.amplitude.monthly-active-user"

    var apiKey: String
    var secretKey: String
    var refreshInterval: Float
}
