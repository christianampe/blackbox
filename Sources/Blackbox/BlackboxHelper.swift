//
//  File.swift
//  
//
//  Created by Christian Ampe on 6/23/19.
//

import Foundation

// MARK: - File Name Helpers
 enum BlackboxHelper {
    
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
private extension BlackboxHelper {
    
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
