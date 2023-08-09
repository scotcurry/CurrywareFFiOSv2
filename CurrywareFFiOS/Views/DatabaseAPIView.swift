//
//  DatabaseAPIView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/7/23.
//

import SwiftUI

struct DatabaseAPIView: View {
    
    @StateObject private var stateTaxListIdentifiable = SalesTaxListObservable()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(stateTaxListIdentifiable.salesTaxList) {item in
                    Text(item.stateName)
                }
            }
        }
    }
}

struct DatabaseAPIView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseAPIView()
    }
}
