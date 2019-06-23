//
//  Created by Christian Ampe on 12/13/18.
//

/// The features to be logged using the `ConsoleLogger`.  In order to see the logs for
/// a certain feature, navigate to `ConsoleLoggerFeature+ConsoleLoggable.swift` and find
/// the feature's associated `shouldPrintToConsole` value and toggle it to `true`.
///
/// Never commit changes to this file or `ConsoleLoggerFeature+ConsoleLoggable.swift`
/// unless it involves the addition of a new feature.  If adding a new feature,
/// default its `shouldPrintToConsole` value to false as this is how all flags should remain.
enum ConsoleLoggerFeature: Hashable {
    case analytics(Analytics)
    case core(Core)
    case entitlements(Entitlements)
}

extension ConsoleLoggerFeature {
    
    /// Sub-features in analytics allowing for more granular distinction.
    enum Analytics: Hashable {
        case adobe
        case appsFlyer
        case conviva
        case leapfrog
        case nielsen
        case optimizely
        case segment
        case miscellaneous
    }
}

extension ConsoleLoggerFeature {
    
    /// Sub-features in core allowing for more granular distinction.
    enum Core: Hashable {
        case bww
        case api
        case deeplinking
        case detailScreen
        case epgScreen
        case findScreen
        case homeScreen
        case onboarding
        case player
        case profile
        case refresh
        case settingsScreen
        case startUp
        case topShelf
        case trueX
        case miscellaneous
    }
}

extension ConsoleLoggerFeature {
    
    /// Sub-features in entitlements allowing for more granular distinction.
    enum Entitlements: Hashable {
        case d2c
        case foxNation
        case miscellaneous
    }
}
