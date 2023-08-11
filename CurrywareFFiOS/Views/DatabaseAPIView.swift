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
                ForEach(stateTaxListIdentifiable.salesTaxListItems) {item in
                    Text(item.stateName)
                }
            }
            .navigationTitle("State Sales Tax Rates")
            .listStyle(.plain)
            .refreshable {
                await stateTaxListIdentifiable.getSalesTaxList()
            }
        }
        .task {
            await stateTaxListIdentifiable.getSalesTaxList()
        }
    }
}

struct DatabaseAPIView_Previews: PreviewProvider {
    static var previews: some View {
        DatabaseAPIView()
    }
}
