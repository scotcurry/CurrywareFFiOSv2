//
//  LeaguesList.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import Foundation

struct LeagueList: Identifiable {
    
    var id: UUID
    var gameID: Int
    var leagueID: Int
    var teamNumber: Int
    var leagueName: String
    var leagueDisplayName: String
    
    init(id: UUID = UUID(), gameID: Int, leagueID: Int, teamNumber: Int, leagueName: String, leagueDisplayName: String) {
        
        self.id = id
        self.gameID = gameID
        self.teamNumber = teamNumber
        self.leagueID = leagueID
        self.leagueName = leagueName
        self.leagueDisplayName = leagueDisplayName
    }
}

extension LeagueList {
    
    static var leagueData: [LeagueList] {
        [
            LeagueList(gameID: 423, leagueID: 321592, teamNumber: 10, leagueName: "olcc_2023", leagueDisplayName: "OLCC 2023"),
            LeagueList(gameID: 423, leagueID: 670923, teamNumber: 10, leagueName: "picard_2023", leagueDisplayName: "Picard 2023"),
            LeagueList(gameID: 414, leagueID: 951179, teamNumber: 11, leagueName: "olcc_2022", leagueDisplayName: "OLCC 2022"),
            LeagueList(gameID: 414, leagueID: 665216, teamNumber: 10, leagueName: "picard_2022", leagueDisplayName: "Picard 2022")
        ]
    }
}
