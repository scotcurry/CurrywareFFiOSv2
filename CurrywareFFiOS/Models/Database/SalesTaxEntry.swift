//
//  SalesTaxEntry.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/8/23.
//

import Foundation

struct SalesTaxEntry: Codable {
    
    var stateNameLong: String
    var taxRate: Double
    var stateName: String
    
    enum CodingKeys: String, CodingKey {
        case stateName = "Name"
        case taxRate = "TaxRate"
        case stateNameLong = "StateName"
    }
}
