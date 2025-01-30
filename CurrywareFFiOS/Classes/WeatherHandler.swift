//
//  WeatherClass.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 10/19/24.
//

import os
import OSLog
import CoreLocation

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var logger = Logger()
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted:
            logger.info("Authorization Restricted")
        case .authorizedWhenInUse:
            logger.info("Authorized When In Use")
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
        case .denied:
            logger.info("Authorization Denied")
        case .notDetermined:
            logger.info("Authorization Not Determined")
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedAlways:
            logger.info("Authorization Always")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        LoggingHandler.createLogEntry(message: "Location Updated")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
        LoggingHandler.createLogEntry(message: "Location Failed with Error")
        LoggingHandler.createLogEntry(message: "Error: \(error.localizedDescription)")
    }
}
