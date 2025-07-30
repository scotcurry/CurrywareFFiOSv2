//
//  PlayerInfo.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 7/12/25.
//

import Foundation

@MainActor
class PlayerInfoList: ObservableObject {
    
    @Published private(set) var playerInfoList: [LeagueSetting] = []
    
    func getLeagueSettings() {
        
        LoggingHandler.createLogEntry(message: "Starting getLeagueSettings")
    }
}
