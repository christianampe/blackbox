//
//  Created by Christian Ampe on 6/23/19.
//

import Foundation

public protocol Blackbox {
    
    /// A list of features to be logged in the application.
    associatedtype Feature: BlackboxFeature
    
    /// A method used to normalize console logging.
    /// Logging only set up for non-release builds.
    ///
    /// The preprocessor macro avoids unneeded print calls in production.
    /// Uncomment the preprocessor macro for release builds for compiler optimization.
    ///
    /// - Parameter message: A message associated with the log.
    /// - Parameter feature: The feature which is being logged.
    /// - Parameter priority: The level of importance this message holds.
    /// - Parameter file: The file from where this logging method was called.
    /// - Parameter function: The function from which this logging method was called.
    /// - Parameter line: The line where this logging method was called.
    static func print(message: Any...,
                      feature: Feature,
                      priority: BlackboxPriority,
                      file: String,
                      function: String,
                      line: Int)
}

// MARK: - Default Implementation
extension Blackbox {
    static func print(message: Any...,
                      feature: Feature,
                      priority: BlackboxPriority,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        
        // A `DEBUG` preprocessor macro which will strip print calls from all environments except `DEBUG`.
        #if DEBUG

        // Ensure this feature should be logged, otherwise bail.
        guard feature.shouldLog else {
            return
        }
        
        // Add an initial new line to avoid logs blending together.
        var log: String = "\n"
        
        add(priority: priority, to: &log)
        add(location: (file: file, function: function, line: line), to: &log)
        add(message: message, to: &log)
        
        // Use the `Swift` default `print` method to log the message.
        Swift.print(log)
        
        #endif
    }
}

// MARK: - Message Constructor Helpers
private extension Blackbox {
    
    /// Adds the priority textual representation to the input log.
    /// By default this method will add a new line to the end of the log.
    ///
    /// - Parameter priority: Priority of the log to be displayed to the user.
    /// - Parameter log: The current log to be mutated.
    static func add(priority: BlackboxPriority,
                    to log: inout String) {
        
        log += "[\(priority.description)]\n"
    }
    
    /// Adds the textual representation of the call location to the input log.
    /// By default this method will add a new line to the end of the log.
    ///
    /// - Parameter location: Location where the statement was called.
    /// - Parameter log: The current log to be mutated.
    static func add(location: (file: String, function: String, line: Int),
                    to log: inout String) {
        
        log += "\(name(ofFile: location.file)).\(location.function):\(location.line)\n"
    }
    
    /// Adds a message objects to the input log.
    /// By default this method will add a new line to the end of the log.
    ///
    /// - Parameter objects: Objects to be textually represented in a log. Separated by a new line.
    /// - Parameter log: The current log to be mutated.
    static func add(message objects: Any...,
                    to log: inout String) {
        
        for object in objects {
            log += "\(object)\n"
        }
    }
}

// MARK: - File Name Helpers
private extension Blackbox {
    
    /// Method used to extract the pure file name from the file path.
    /// Strips out the directory structure from the string.
    /// Removes the file name extension.
    ///
    /// - Parameter file: Name of a file to be modified.
    /// - Returns: The directory stripped pure file name.
    static func name(ofFile file: String) -> String {
        guard let lastPart = file.components(separatedBy: "/").last else {
            return ""
        }
        
        guard !lastPart.isEmpty, let firstPart = lastPart.components(separatedBy: ".").first else {
            return ""
        }
        
        return firstPart
    }
}
