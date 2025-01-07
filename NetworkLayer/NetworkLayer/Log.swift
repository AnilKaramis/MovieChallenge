//
//  Log.swift
//  NetworkLayer
//
//  Created by YusufDemirkoparan on 26.07.2024.
//

import Foundation
import os.log
import UIKit

let Log = Logger()

extension Logger {
    // The subsystem identifier for the app
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.Logger"

    // Custom log categories
    static let network = Logger(subsystem: subsystem, category: "Network")
    static let database = Logger(subsystem: subsystem, category: "Database")
    static let ui = Logger(subsystem: subsystem, category: "UI")

    // Log levels
    enum LogLevel: String {
        case debug
        case info
        case warning
        case error
        case fault
    }

    // Privacy levels for sensitive data
    enum PrivacyLevel {
        case `private`
        case `public`
    }

    // Log method
    func log(_ message: String, level: LogLevel, category: String, privacy: PrivacyLevel = .public, file: String = #file, function: String = #function, line: Int = #line) {
        let logger = Logger(subsystem: Logger.subsystem, category: category)

        var logMessage = "\(message) - [\((file as NSString).lastPathComponent):\(line) - \(function)]"

        if privacy == .private {
            logMessage = "[\(privacy)] \(logMessage)"
        }

        switch level {
        case .debug:
            logger.debug("\(logMessage)")
        case .info:
            logger.info("\(logMessage)")
        case .warning:
            logger.warning("\(logMessage)")
        case .error:
            logger.error("\(logMessage)")
        case .fault:
            logger.fault("\(logMessage)")
        }
    }
}

// let logger = Logger()
//
//// Log an info message for application startup
// logger.log("Application started.", level: .info, category: "Application")
//// Output: [2023-05-07 10:00:00] [Application] [info] Application started. - [FileName.swift:50 - someFunction()]
//
//// Log a debug message for a network request
// logger.log("API request sent: \(urlString)", level: .debug, category: "Network")
//// Output: [2023-05-07 10:01:00] [Network] [debug] API request sent: https://api.example.com/data - [FileName.swift:52 - someFunction()]
//
//// Log an info message for user login with private privacy level
// logger.log("User logged in: \(username)", level: .info, category: "Authentication", privacy: .private)
//// Output: [2023-05-07 10:02:00] [Authentication] [info] [private] User logged in: johndoe - [FileName.swift:54 - someFunction()]
//
//// Log an error message for a database error
// logger.log("Database error occurred: \(error.localizedDescription)", level: .error, category: "Database")
//// Output: [2023-05-07 10:03:00] [Database] [error] Database error occurred: Failed to connect to the database. - [FileName.swift:56 - someFunction()]
//
//// Log a fault message for a critical error
// logger.log("A critical error occurred!", level: .fault, category: "Application")
//// Output: [2023-05-07 10:04:00] [Application] [fault] A critical error occurred! - [FileName.swift:58 - someFunction()]
