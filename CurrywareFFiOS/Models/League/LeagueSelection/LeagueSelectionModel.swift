//
//  GameInfo.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 4/18/25.
//

import Foundation

struct LeagueSelectionModel: Codable, Identifiable
{
    
    var league_id: String?
    var game_id: String?
    var team_name: String?
    var paid_league: Bool
    
    init(league_id: String? = nil, game_id: String? = nil, team_name: String? = nil, paid_league: Bool) {
        self.league_id = league_id
        self.game_id = game_id
        self.team_name = team_name
        self.paid_league = paid_league
    }
    
    enum CodingKeys: String, CodingKey {
        case league_id
        case game_id
        case team_name
        case paid_league
    }
    
    var id: String {
        league_id ?? UUID().uuidString
    }
}
