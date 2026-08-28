// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AmplitudeWidget",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .library(
            name: "AmplitudeWidget",
            targets: ["AmplitudeWidget"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hartakji/daashi-widget-foundation", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "AmplitudeWidget",
            dependencies: [
                .product(
                    name: "WidgetFoundation",
                    package: "daashi-widget-foundation"
                )
            ],
            path: "Sources"
        )
    ]
)

