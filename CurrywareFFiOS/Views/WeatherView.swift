//
//  WeatherView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 10/19/24.
//

import os
import SwiftUI

struct WeatherView: View {
    
    @StateObject var locationManager = LocationDataManager()
    // let logger = Logger()
    
    var body: some View {
        
        VStack {
            
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                Text("Your current location is:")
                Text("Lattitude: \(String(describing: locationManager.locationManager.location?.coordinate.latitude))")
                Text("Longitude: \(String(describing: locationManager.locationManager.location?.coordinate.longitude))")

            default:
                Text("Default Authorization Status")
            }
        }
    }
}

#Preview {
    WeatherView()
}
