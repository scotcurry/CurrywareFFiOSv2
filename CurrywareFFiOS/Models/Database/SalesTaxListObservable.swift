//
//  SalesTaxList.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/8/23.
//

import Foundation
import DatadogTrace

@MainActor
class SalesTaxListObservable: ObservableObject {
    
    @Published private(set) var salesTaxListItems: [SaleTaxEntryIdentifiable] = []
    
    func getSalesTaxList() async {
        
        let tracer = Tracer.shared()
        let span = tracer.startRootSpan(operationName: "getSalesTaxList", tags: ["env": "prod"], startTime: nil)
        let spanContext = span.context
        
        let databaseHandler = DatabaseAPIHandler()
        print("Getting getSalesTaxList()")
        LoggingHandler.createLogEntry(message: "Getting getSalesTaxList()")
        do {
            let fetchSalesTaxEntries = try await databaseHandler.makeDatabaseAPICall(rootSpan: span)
            var tempSalesTaxList: [SaleTaxEntryIdentifiable] = []
            for saleTaxEntry in fetchSalesTaxEntries {
                let id = UUID()
                let salesTaxEntryIdentifiable = SaleTaxEntryIdentifiable(
                    id: id, stateNameLong: saleTaxEntry.stateNameLong, taxRate: saleTaxEntry.taxRate, stateName: saleTaxEntry.stateName)
                tempSalesTaxList.append(salesTaxEntryIdentifiable)
            }
            print("Tax Entries: \(tempSalesTaxList.count)")
            LoggingHandler.createLogEntry(message: "Tax Entries: \(tempSalesTaxList.count)")
            salesTaxListItems = tempSalesTaxList
            
        } catch DatabaseHandlerError.inValidResponse {
            print("Got an invalid response!")
        } catch DatabaseHandlerError.noDatabaseURL {
            print("Didn't get a database URL!")
        } catch {
            print("Unknown Exception!")
        }
        
        span.finish()
    }
}
