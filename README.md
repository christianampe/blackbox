# Blackbox

### Inspiration

> Blackbox is a lightweight package built with the intent of normalizing the way logging is handled in you application.

## Usage

#### Provide Features to Log

To begin using `Blackbox` provide a set of features which conform to `BlackboxFeature`

```swift
enum ApplicationFeature {
    case analytics(Analytics)
    case login(Login)
    case main(Main)
    case optimizing(Optimizing)
}

extension ApplicationFeature: BlackboxFeature {
    var shouldLog: Bool {
        switch self {
        case .analytics(let feature):
            return feature.shouldLog
        case .login(let feature):
            return feature.shouldLog
        case .main(let feature):
            return feature.shouldLog
        case .optimizing(let feature):
            return feature.shouldLog
        }
    }

    var description: String {
        switch self {
        case .analytics(let feature):
            return "analytics \(feature.description)"
        case .login(let feature):
            return "login \(feature.description)"
        case .main(let feature):
            return "main \(feature.description)"
        case .optimizing(let feature):
            return "optimizing \(feature.description)"
        }
    }
}

// MARK - Subfeatures
extension ApplicationFeature {
    enum Analytics {
        case adobe
        case segment
    }
}

extension ApplicationFeature.Analytics: BlackboxFeature {
    var shouldLog: Bool {
        switch self {
        case .adobe:
            return false
        case .segment:
            return false
        }
    }

    var description: String {
        switch self {
        case .adobe:
            return "adobe"
        case .segment:
            return "segment"
        }
    }
}

extension ApplicationFeature {
    enum Login {
        case loginIn
        case signUp
    }
}

extension ApplicationFeature.Login: BlackboxFeature {
    var shouldLog: Bool {
        switch self {
        case .loginIn:
            return true
        case .signUp:
            return true
        }
    }

    var description: String {
        switch self {
        case .loginIn:
            return "log in"
        case .signUp:
            return "sign up"
        }
    }
}

extension ApplicationFeature {
    enum Main {
        case post
        case profile
    }
}

extension ApplicationFeature.Main: BlackboxFeature {
    var shouldLog: Bool {
        switch self {
        case .post:
            return false
        case .profile:
            return false
        }
    }

    var description: String {
        switch self {
        case .post:
            return "post"
        case .profile:
            return "profile"
        }
    }
}

extension ApplicationFeature {
    enum Optimizing {
        case optimizely
    }
}

extension ApplicationFeature.Optimizing: BlackboxFeature {
    var shouldLog: Bool {
        switch self {
        case .optimizely:
            return false
        }
    }

    var description: String {
        switch self {
        case .optimizely:
            return "optimizely"
        }
    }
}

```
`BlackboxFeature` requires a `shouldLog` flag and a `description` string for each feature. The `shouldLog` flag allows for a customizable logging experience. When set to false, all logging of the given feature will not be seen - this is especially useful in situations where a set of developers are working on specific features and only need to see the logs from the features they are working on. The `description` string is used to identify which feature is being logged. Provide a name which accurately and uniquely identifies the feature.

Provide this set of features to your logger by constructing a concrete impelementation and passing the features as its `typealias`.

```swift
struct TestApplicationLogger: Blackbox {
    typealias Feature = ApplicationFeature
}
```
It is now possible to begin logging.

```swift
TestApplicationLogger.print(message: "server unreachable",
                            feature: .login(.signUp),
                            priority: .alert)
```
