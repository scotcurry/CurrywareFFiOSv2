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
    
    // The first question mark means the actual infoDictionary may be nil.  The as? does an "optional" downcast, which
    // tries to take the type of Any and cast it to string.  This may not work.
    // let leagueList = LeagueList.leagueData
    // let leagueSettings = LeagueSetting.sampleData
    
    var body: some Scene {
        WindowGroup {
            // InitialContent(leagueList: leagueList, leagueSettings: leagueSettings)
            NavigationHandlerView()
        }
    }
}
