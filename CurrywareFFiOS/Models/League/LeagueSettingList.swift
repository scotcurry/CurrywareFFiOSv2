//
//  LeagueSettingList.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/8/23.
//

import Foundation

@MainActor
class LeagueSettingList: ObservableObject {
    
    @Published private(set) var leagueSettingsList: [LeagueSetting] = []
    
    func getLeagueSettings() {
        
    }
}
