//
//  Created by Christian Ampe on 12/14/18.
//

/// Priority of the log sent to the console.
/// Used to format the log according to assoicated priority.
///
/// Levels pulled from [wikipedia](https://en.wikipedia.org/wiki/Syslog#Severity_level).
enum ConsoleLoggerPriority: Int {
    
    /// System is unusable.
    case emergency = 0
    
    /// Action must be taken immediately.
    case alert
    
    /// Critical conditions.
    case critical
    
    /// Error conditions.
    case error
    
    /// Warning conditions.
    case warning
    
    /// Normal but significant conditions.
    case notice
    
    /// Informational messages.
    case informational
    
    /// Debug-level messages.
    case debug
}

extension ConsoleLoggerPriority {
    
    /// The uppercased textual representation of the priorities.
    var name: String {
        switch self {
        case .emergency:
            return "EMERGENCY"
        case .alert:
            return "ALERT"
        case .critical:
            return "CRITICAL"
        case .error:
            return "ERROR"
        case .warning:
            return "WARNING"
        case .notice:
            return "NOTICE"
        case .informational:
            return "INFORMATIONAL"
        case .debug:
            return "DEBUG"
        }
    }
}
