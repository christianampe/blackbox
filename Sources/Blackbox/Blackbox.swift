//
//  File.swift
//  
//
//  Created by Christian Ampe on 6/23/19.
//

import Foundation

public protocol Blackbox {
    
    associatedtype Feature: BlackboxFeature
    
    associatedtype Priority: BlackboxPriority
    
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
    static func print(message: [Any],
                      feature: Feature,
                      priority: Priority,
                      file: String,
                      function: String,
                      line: Int) {
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
