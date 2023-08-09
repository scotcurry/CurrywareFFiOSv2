//
//  SalesTaxList.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/8/23.
//

import Foundation
import os

class SalesTaxListObservable: ObservableObject {
    
    @Published var salesTaxList: [SaleTaxEntryIdentifiable] = []
    
    func getSalesTaxList() async {
        
        let databaseHandler = DatabaseAPIHandler()
        print("Getting getSalesTaxList()")
        do {
            let fetchSalesTaxEntries = try await databaseHandler.makeDatabaseAPICall()
            var tempSalesTaxList: [SaleTaxEntryIdentifiable] = []
            for saleTaxEntry in fetchSalesTaxEntries {
                let id = UUID()
                let salesTaxEntryIdentifiable = SaleTaxEntryIdentifiable(
                    id: id, stateNameLong: saleTaxEntry.stateNameLong, taxRate: saleTaxEntry.taxRate, stateName: saleTaxEntry.stateName)
                tempSalesTaxList.append(salesTaxEntryIdentifiable)
            }
            print("Tax Entries: \(tempSalesTaxList.count)")
            salesTaxList = tempSalesTaxList
            
        } catch DatabaseHandlerError.inValidResponse {
            print("Got an invalid response!")
        } catch DatabaseHandlerError.noDatabaseURL {
            print("Didn't get a database URL!")
        } catch {
            print("Unknown Exception!")
        }
    }
}
