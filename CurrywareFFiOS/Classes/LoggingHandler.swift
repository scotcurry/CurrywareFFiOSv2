//
//  LoggingHandler.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/9/23.
//

import Foundation

import DatadogLogs

struct LoggingHandler {
    
    static func createLogEntry(message: String) {
        
        let loggerConfiguration = Logger.Configuration(
            name: "currywareffios",
            networkInfoEnabled: true,
            remoteLogThreshold: .info,
            consoleLogFormat: .shortWith(prefix: "iOS")
        )
        let logger = Logger.create(with: loggerConfiguration)
        logger.info(message)
    }
}
