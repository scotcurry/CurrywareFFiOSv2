//
//  LeagueSetting.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import Foundation

struct LeagueSetting: Identifiable, Codable {
    
    var id: UUID
    var statID: Int
    var statName: String
    var statDisplayName: String
    var statGroup: String
    var statValue: Double
    var statBonusTarget: Int
    var statBonusPoints: Int
    
    init(id: UUID = UUID(), statID: Int, statName: String, statDisplayName: String, statGroup: String, statValue: Double, statBonusTarget: Int, statBonusPoints: Int) {
        
        self.id = id
        self.statID = statID
        self.statName = statName
        self.statDisplayName = statDisplayName
        self.statGroup = statGroup
        self.statValue = statValue
        self.statBonusTarget = statBonusTarget
        self.statBonusPoints = statBonusPoints
        //LoggingHandler.createLogEntry(message: "Hello Scot")
    }
}

extension LeagueSetting {
    
    static var sampleData: [LeagueSetting] {
        [
            LeagueSetting(statID: 4, statName: "Passing Yards", statDisplayName: "Pass Yds", statGroup: "passing", statValue: 0.04, statBonusTarget: 300, statBonusPoints: 5),
            LeagueSetting(statID: 5, statName: "Passing Touchdowns", statDisplayName: "Pass TD", statGroup: "passing", statValue: 4, statBonusTarget: 0, statBonusPoints: 0)
        ]
    }
}
