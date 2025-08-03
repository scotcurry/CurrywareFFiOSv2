//
//  LeagueSettingList.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/3/25.
//

import Foundation

@MainActor
class LeagueSettingList: ObservableObject {
    
    @Published private(set) var leagueSettingsList: [LeagueSetting] = []
    
    func getLeagueSettings() {
        
        LoggingHandler.createLogEntry(message: "Starting getLeagueSettings")
    }
}
