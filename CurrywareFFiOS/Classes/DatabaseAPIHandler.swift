//
//  DatabaseAPIHandler.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/7/23.
//

import Foundation
import os

struct DatabaseAPIHandler {
    
    func makeDatabaseAPICall() async throws -> [SalesTaxEntry] {
        
        let databaseURL = BundleHandler.getDatabaseAPIURL()
        if let databaseURL = URL(string: databaseURL) {
            let request = URLRequest(url: databaseURL)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let validRange = 200...299
            guard let httpResponse = response as? HTTPURLResponse,
                  validRange ~= httpResponse.statusCode else {
                throw DatabaseHandlerError.inValidResponse
            }
            let salesTaxList: SalesTaxList = try JSONDecoder().decode(SalesTaxList.self, from: data)
            let salesTaxEntries = salesTaxList.stateSalesTaxList
            return salesTaxEntries
        } else {
            throw DatabaseHandlerError.noDatabaseURL
        }
    }
}

enum DatabaseHandlerError: Error {
    
    case inValidResponse
    case noDatabaseURL
}
