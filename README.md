# AmplitudeWidget

A Swift package that provides a [Daashi Widget Foundation](https://github.com/hartakji/daashi-widget-foundation) widget pack for interacting with [Amplitude](https://amplitude.com)'s REST API. It exposes ready-to-use dashboard widgets built on top of Amplitude analytics data.

## Requirements

- iOS 16.0+
- Swift 5.7+
- A [`daashi-widget-foundation`](https://github.com/hartakji/daashi-widget-foundation) host application

## Installation

Add the package as a dependency via Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/hartakji/daashi-amplitude-package", from: "1.0.0")
]
```

## Widget Pack

The package registers itself with the Widget Foundation via `AmplitudeWidgetPackDescriptor`, which declares the pack's metadata (name, description, icon) and the list of widgets it provides.

### Monthly Active Users

Displays the number of active users for the current month, along with the percentage change compared to the previous month and the start date of the current period.

- **Identifier**: `daashi.amplitude.monthly-active-user`
- **Available form factor**: square
- **Available size**: small

#### Configuration

The widget is configured with an Amplitude API key/secret pair and a refresh interval:

```swift
public struct MonthlyActiveUsersConfig: WidgetConfigPayload {
    var apiKey: String
    var secretKey: String
    var refreshInterval: Float // in minutes, 15...180
}
```

A SwiftUI configuration form (`MonthlyActiveUsersConfigView`) is provided out of the box for entering credentials and setting the refresh frequency.

#### How it works

The widget fetches data from Amplitude's `/api/2/users` endpoint using HTTP Basic authentication built from the configured API key/secret, and refreshes automatically on the configured interval:

1. **Data** (`MonthlyActiveUsersStore`) — calls the Amplitude REST API and decodes the response into DTOs.
2. **Domain** (`MonthlyActiveUsersInteractor`) — computes the current/last month window and maps DTOs into the `ActiveUsers` domain model.
3. **UI** (`MonthlyActiveUsersView`, `MonthlyActiveUsersViewModel`, `MonthlyActiveUsersEventHandler`) — renders the widget and periodically refreshes it via the event handler's refresh loop.

## Architecture

Each widget in this package follows a layered structure:

```
Sources/MonthlyActiveUser/
├── Data/       # Network/DTO layer (Store, DTOs)
├── Domain/     # Business logic (Interactor, domain models, protocols)
└── UI/         # SwiftUI views, view models, config, and event handling
```

## License

See the repository for license details.  
