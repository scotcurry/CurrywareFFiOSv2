//
//  LoggingHandler.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/9/23.
//

// import os
import Foundation
import DatadogCore
import DatadogLogs

public struct LoggingHandler {
    
    static func createLogEntry(message: String) {
        
        let clientToken: String = BundleHandler.getClientToken()

        let datadogConfiguration = Datadog.Configuration(
            clientToken: clientToken,
            env: "prod")
        
        let loggerConfiguration = Logger.Configuration(
            name: "currywareffios",
            networkInfoEnabled: true,
            remoteLogThreshold: .info,
            consoleLogFormat: .shortWith(prefix: "iOS")
        )
        let ddInitialized = Datadog.isInitialized()
        
        if ddInitialized == false {
            Datadog.initialize(with: datadogConfiguration, trackingConsent: .pending)
            let logger = Logger.create(with: loggerConfiguration)
            logger.info("Initialized Logger")
        } else {
            let logger = Logger.create(with: loggerConfiguration)
            logger.info("Did not initialize Logger")
        }
    }
}
