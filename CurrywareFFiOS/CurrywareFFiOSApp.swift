//
//  CurrywareFFiOSApp.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import SwiftUI

@main
struct CurrywareFFiOSApp: App {
    
    // This calls the code in Classes -> AppDelegate
    // (https://github.com/scotcurry/CurrywareFFiOSv2/blob/main/CurrywareFFiOS/Classes/AppDelegate.swift).  These are all lifecycle changes that are available for handling.
    
    // https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // let _ = DatadogRumHandler.startDatadog()
        WindowGroup {
            LeagueSelectionView()
        }
    }
}
