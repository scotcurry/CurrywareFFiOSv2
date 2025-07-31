//
//  PlayerInfo.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 7/12/25.
//

import Foundation

struct PlayerInfo: Codable, Identifiable {
    
    // var id: UUID
    var id: String
    var playerSeasonKey: String
    var playerName: String
    var playerUrl: String
    var playerTeam: String
    var playerByeWeek: Int
    var playerUniformNumber: Int
    var playerPosition: String
    var playerHeadshot: String
    
    enum CodingKeys: String, CodingKey {
        case id = "player_id"
        case playerSeasonKey = "player_season_key"
        case playerName = "player_name"
        case playerUrl = "player_url"
        case playerTeam = "player_team"
        case playerByeWeek = "player_bye_week"
        case playerUniformNumber = "player_uniform_number"
        case playerPosition = "player_position"
        case playerHeadshot = "player_headshot"
    }
    
    init(id: String, playerSeasonKey: String, playerName: String, playerUrl: String, playerTeam: String, playerByeWeek: Int,
         playerUniformNumber: Int, playerPosition: String, playerHeadshot: String) {
        
        // self.id = id
        self.id = id
        self.playerSeasonKey = playerSeasonKey
        self.playerName = playerName
        self.playerUrl = playerUrl
        self.playerTeam = playerTeam
        self.playerByeWeek = playerByeWeek
        self.playerUniformNumber = playerUniformNumber
        self.playerPosition = playerPosition
        self.playerHeadshot = playerHeadshot
    }
}
