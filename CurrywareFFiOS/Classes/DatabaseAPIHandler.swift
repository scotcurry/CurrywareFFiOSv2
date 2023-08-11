//
//  DatabaseAPIHandler.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/7/23.
//

import Foundation
import DatadogTrace

struct DatabaseAPIHandler {
    
    // Trying to pass the origanal span (via context) and tracer into the call to add the HTTP Headers
    func makeDatabaseAPICall(rootSpan: OTSpan) async throws -> [SalesTaxEntry] {
        
        let tracer = Tracer.shared()
        let responseSpan = tracer.startSpan(operationName: "makeDatabaseAPICall", childOf: rootSpan.context)
        
        // Datadog functionality.  Build out the headers
        let span = tracer.startSpan(operationName: "makeDatabaseAPICall", childOf: rootSpan.context)
        LoggingHandler.createLogEntry(message: "Trying makeDatabaseAPICallSpan")
        //let headerWriter = DatadogInternal.HTTPHeadersWriter(samplingRate: 100)
        
        let databaseURL = BundleHandler.getDatabaseAPIURL()
        if let databaseURL = URL(string: databaseURL) {
            let request = URLRequest(url: databaseURL)
            // request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let validRange = 200...299
            guard let httpResponse = response as? HTTPURLResponse,
                  validRange ~= httpResponse.statusCode else {
                throw DatabaseHandlerError.inValidResponse
            }
            let salesTaxList: SalesTaxList = try JSONDecoder().decode(SalesTaxList.self, from: data)
            let salesTaxEntries = salesTaxList.stateSalesTaxList
            responseSpan.finish()
            return salesTaxEntries
        } else {
            throw DatabaseHandlerError.noDatabaseURL
        }
        responseSpan.finish()
    }
}

enum DatabaseHandlerError: Error {
    
    case inValidResponse
    case noDatabaseURL
}
