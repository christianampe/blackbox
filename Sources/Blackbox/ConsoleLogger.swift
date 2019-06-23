//
//  Created by Christian Ampe on 12/14/18.
//

/// A method used to normalize console logging.
/// Logging only set up for non-release builds.
///
/// The preprocessor macro avoids unneeded print calls in production.
///
/// - Parameters:
///   - message: A message associated with the log.
///   - feature: The feature which is being logged.
///   - priority: The level of importance this message holds.
///   - file: The file from where this logging method was called.
///   - function: The function from which this logging method was called.
///   - line: The line where this logging method was called.
func print(message: Any...,
           feature: ConsoleLoggerFeature,
           priority: ConsoleLoggerPriority,
           _ file: String = #file,
           _ function: String = #function,
           _ line: Int = #line) {
    
    #if DEBUG
    
    ConsoleLogger.print(message: message,
                        feature: feature,
                        priority: priority,
                        file: file,
                        function: function,
                        line: line)
    
    #endif
}

private class ConsoleLogger {
    
    /// A method used to normalize console logging.
    /// Logging only set up for non-release builds.
    ///
    /// The preprocessor macro avoids unneeded print calls in production.
    /// Uncomment the preprocessor macro for release builds for compiler optimization.
    ///
    /// - Parameters:
    ///   - message: A message associated with the log.
    ///   - feature: The feature which is being logged.
    ///   - priority: The level of importance this message holds.
    ///   - file: The file from where this logging method was called.
    ///   - function: The function from which this logging method was called.
    ///   - line: The line where this logging method was called.
    static func print(message: [Any],
                      feature: ConsoleLoggerFeature,
                      priority: ConsoleLoggerPriority,
                      file: String,
                      function: String,
                      line: Int) {
        
        // ensure the feature has been added to the loggables feature enum
        guard feature.shouldPrintToConsole else {
            return
        }
        
        var log: String = "\n"
        
        append(priority: priority, to: &log)
        append(location: (file: file, function: function, line: line), to: &log)
        append(message: message, to: &log)
        
        Swift.print(log)
    }
}

// MARK: - File Name Helpers
private extension ConsoleLogger {
    
    /// Method used to extract the pure file name from the file path.
    /// Strips out the directory structure from the string.
    ///
    /// - Parameter file: Name of a file to be modified.
    /// - Returns: The directory stripped pure file name.
    static func nameOf(_ file: String) -> String {
        guard let lastPart = file.components(separatedBy: "/").last else {
            return ""
        }
        
        return lastPart
    }
    
    /// Method used to remove the extension from a file name.
    ///
    /// - Parameter file: Name of a file to be modified.
    /// - Returns: Returns a file name with no extension.
    static func suffixlessNameOf(_ file: String) -> String {
        let fileName = nameOf(file)
        
        guard !fileName.isEmpty, let firstPart = fileName.components(separatedBy: ".").first else {
            return ""
        }
        
        return firstPart
    }
}

// MARK: - Message Constructor Helpers
private extension ConsoleLogger {
    
    /// Adds the priority textual representation to the input log.
    /// By default this method will add a new line to the end of the log.
    ///
    /// - Parameters:
    ///   - priority: Priority of the log to be displayed to the user.
    ///   - log: The current log to be mutated.
    static func append(priority: ConsoleLoggerPriority, to log: inout String) {
        log += "[\(priority.name)]"
        log += "\n"
    }
    
    /// Adds the textual representation of the call location to the input log.
    /// By default this method will add a new line to the end of the log.
    ///
    /// - Parameters:
    ///   - location: Location where the statement was called.
    ///   - log: The current log to be mutated.
    static func append(location: (file: String, function: String, line: Int), to log: inout String) {
        log += "\(suffixlessNameOf(location.file)).\(location.function):\(location.line)"
        log += "\n"
    }
    
    /// Adds a message objects to the input log.
    /// By default this method will add a new line to the end of the log.
    ///
    /// - Parameters:
    ///   - objects: Objects to be textually represented in a log. Separated by a new line.
    ///   - log: The current log to be mutated.
    static func append(message objects: [Any], to log: inout String) {
        for object in objects {
            log += "\(object)"
            log += "\n"
        }
    }
}
