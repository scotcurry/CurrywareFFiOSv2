//  Created by Scot Curry on 8/8/23.
//

import Foundation

struct SaleTaxEntryIdentifiable: Identifiable {

    var id: UUID
    var stateNameLong: String
    var taxRate: Double
    var stateName: String
    
    init(id: UUID, stateNameLong: String, taxRate: Double, stateName: String) {
        self.id = id
        self.stateNameLong = stateNameLong
        self.taxRate = taxRate
        self.stateName = stateName
    }
}
