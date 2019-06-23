//
//  Created by Christian Ampe on 6/23/19.
//

/// Priority of the log sent to the console.
/// Used to format the log according to assoicated priority.
///
/// Levels pulled from [wikipedia](https://en.wikipedia.org/wiki/Syslog#Severity_level).
public enum BlackboxPriority: String, CustomStringConvertible {
    
    /// System is unusable.
    case emergency
    
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

extension BlackboxPriority {
    
    /// The uppercased textual representation of the priorities.
    public var description: String { rawValue.uppercased() }
}
