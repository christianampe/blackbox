//
//  Created by Christian Ampe on 1/2/19.
//

extension ConsoleLoggerFeature: ConsoleLoggable {
    var shouldPrintToConsole: Bool {
        switch self {
        case .analytics(let feature):
            return feature.shouldPrintToConsole
        case .core(let feature):
            return feature.shouldPrintToConsole
        case .entitlements(let feature):
            return feature.shouldPrintToConsole
        }
    }
}

extension ConsoleLoggerFeature.Analytics: ConsoleLoggable {
    var shouldPrintToConsole: Bool {
        switch self {
        case .adobe:
            return false
        case .appsFlyer:
            return false
        case .conviva:
            return false
        case .leapfrog:
            return false
        case .nielsen:
            return false
        case .optimizely:
            return false
        case .segment:
            return false
        case .miscellaneous:
            return false
        }
    }
}

extension ConsoleLoggerFeature.Core: ConsoleLoggable {
    var shouldPrintToConsole: Bool {
        switch self {
        case .bww:
            return false
        case .api:
            return false
        case .deeplinking:
            return false
        case .detailScreen:
            return false
        case .epgScreen:
            return false
        case .findScreen:
            return false
        case .homeScreen:
            return false
        case .onboarding:
            return false
        case .player:
            return false
        case .profile:
            return false
        case .refresh:
            return false
        case .settingsScreen:
            return false
        case .startUp:
            return false
        case .topShelf:
            return false
        case .trueX:
            return false
        case .miscellaneous:
            return false
        }
    }
}

extension ConsoleLoggerFeature.Entitlements: ConsoleLoggable {
    var shouldPrintToConsole: Bool {
        switch self {
        case .d2c:
            return false
        case .foxNation:
            return false
        case .miscellaneous:
            return false
        }
    }
}
