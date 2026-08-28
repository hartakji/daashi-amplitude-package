//
//  MonthlyActiveUsersConfigView.swift
//  AmplitudeWidget
//
//  Created by Jean DAHER on 28/08/2026.
//

import SwiftUI

struct MonthlyActiveUsersConfigView: View {
    
    @State private var config: MonthlyActiveUsersConfig
    public var onSave: ((MonthlyActiveUsersConfig) -> Void)
    
    init(
        previousConfig: MonthlyActiveUsersConfig? = nil,
        onSave: (@escaping (MonthlyActiveUsersConfig) -> Void)
    ) {
        self.onSave = onSave
        self.config = previousConfig ?? MonthlyActiveUsersConfig(
            apiKey: "",
            secretKey: "",
            refreshInterval: 15
        )
    }
    
    public var body: some View {
        VStack {
            Form {
                Section(header: Text("Credentials")) {
                    TextField("API Key", text: $config.apiKey)
                    TextField("API Secret", text: $config.secretKey)
                }
                Section(header: Text("Refresh frequency")) {
                    Slider(value: $config.refreshInterval, in: 15...180, step: 15)
                    HStack {
                        Spacer()
                        Text("Refresh every \(String(format: "%1.0f", config.refreshInterval)) min")
                    }
                }
            }
            .navigationBarItems(trailing: HStack {
                Button {
                    onSave(config)
                } label: {
                    Text("Save")
                }
            })
        }
    }
}

#Preview {
    MonthlyActiveUsersConfigView(onSave: { config in
        print("config: \(config)")
    })
}
