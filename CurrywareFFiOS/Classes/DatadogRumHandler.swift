//
//  DatadogRumHandler.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import Foundation
import DatadogCore
import DatadogRUM
import DatadogLogs
import DatadogTrace

struct DatadogRumHandler {

    static func startDatadog() {

        let appID: String = BundleHandler.getAppID()
        let clientToken: String = BundleHandler.getClientToken()

        let datadogConfiguration = Datadog.Configuration(
            clientToken: clientToken,
            env: "prod")
        
        Datadog.initialize(with: datadogConfiguration, trackingConsent: .granted)

        // Use this if you want detailed information about the Datadog process.
        Datadog.verbosityLevel = .debug

        let rumConfiguration = RUM.Configuration(
            applicationID: appID,
            uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
            uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate())
        RUM.enable(with: rumConfiguration)

//        Logs.enable()
//        let loggerConfiguration = Logger.Configuration(
//            name: "currywareffios",
//            networkInfoEnabled: true,
//            remoteLogThreshold: .info,
//            consoleLogFormat: .shortWith(prefix: "iOS")
//        )
//        let logger = Logger.create(with: loggerConfiguration)
//        Datadog.verbosityLevel = .debug
//        logger.info("Starting Logging", attributes: ["location": "DatadogRumHandler"])
//        logger.debug("Debug Logging Enabled")
        
        let traceConfiguration = Trace.Configuration(sampleRate: 100, networkInfoEnabled: true)
        Trace.enable(with: traceConfiguration)
    }
    
    static func startLogging() {
        
        Logs.enable()
        let loggerConfiguration = Logger.Configuration(
            name: "currywareffios",
            networkInfoEnabled: true,
            remoteLogThreshold: .info,
            consoleLogFormat: .shortWith(prefix: "iOS")
        )
        let logger = Logger.create(with: loggerConfiguration)
        logger.info("Initializing Logging", attributes: ["location": "DatadogRumHandler.startLogging()"])
    }
 }
