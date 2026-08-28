//
//  AmplitudeWidgetPackDescriptor.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import WidgetFoundation
import SwiftUI

public struct AmplitudeWidgetPackDescriptor: WidgetPackDescriptor {
    
    public static var packInfo: WidgetPackInfo {
        WidgetPackInfo(
            name: "Amplitude",
            description: "Widgets to interface with Amplitude's API",
            image: Image("ic_widgetPack_am", bundle: .module)
        )
    }
    
    public static var widgets: [WidgetFoundation.Widget] {
        [
            Widget(
                identifier: MonthlyActiveUsersConfig.componentIdentifier,
                name: "Monthly Active Users",
                description: "Display monthly active users for your project",
                image: Image("ic_activeUser", bundle: .module),
                availableFormFactor: [.square],
                availableSize: [.small]
            )
        ]
    }

    public static func configType(
        for identifier: String
    ) -> WidgetFoundation.WidgetConfigPayload.Type {
        switch identifier {
        case MonthlyActiveUsersConfig.componentIdentifier:
            return MonthlyActiveUsersConfig.self
        default:
            break
        }
        fatalError("Unable to find config for \(identifier)")
    }
    
    @MainActor
    public static func makeView<T>(
        for identifier: String,
        config: T
    ) -> (AnyView, any WidgetEventHandlerProtocol) where T : WidgetConfigPayload {
        switch identifier {
            
        case MonthlyActiveUsersConfig.componentIdentifier:
            if let config = config as? MonthlyActiveUsersConfig {
                
                let viewModel = MonthlyActiveUsersViewModel(
                    activeUsers: "N/A",
                    sinceDate: "N/A",
                    deltaLastMonth: "N/A"
                )
                let eventHandler = MonthlyActiveUsersEventHandler(
                    config: config,
                    viewModel: viewModel,
                    interactor: MonthlyActiveUsersInteractor(
                        store: MonthlyActiveUsersStore(
                            apiKey: config.apiKey,
                            secretKey: config.secretKey
                        )
                    )
                )

                let view = MonthlyActiveUsersView(viewModel: viewModel, delegate: eventHandler)
                
                return (view: AnyView(view), eventHandler: eventHandler)
            }
        default:
            break
        }
        
        fatalError("Unable to make view for identifier: \(identifier)")
    }
    
    @MainActor
    public static func makeConfigurator(
        for identifier: String,
        config: (any WidgetConfigPayload)?,
        onSave: @escaping (any WidgetConfigPayload) -> Void
    ) -> AnyView {
        switch identifier {
            
        case MonthlyActiveUsersConfig.componentIdentifier:
            if let config = config as? MonthlyActiveUsersConfig? {
                let view = MonthlyActiveUsersConfigView(
                    previousConfig: config,
                    onSave: { newConfig in
                        onSave(newConfig)
                    }
                )
                return AnyView(view)
            }
        default:
            break
        }
        
        fatalError("Unable to make configurator view for identifier: \(identifier)")
    }
}
