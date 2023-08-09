//
//  CurrywareFFiOSApp.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import SwiftUI

@main
struct CurrywareFFiOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // The first question mark means the actual infoDictionary may be nil.  The as? does an "optional" downcast, which
    // tries to take the type of Any and cast it to string.  This may not work.
    let leagueList = LeagueList.leagueData
    
    var body: some Scene {
        WindowGroup {
            LeagueSelectionView(leagueList: leagueList)
        }
    }
}
