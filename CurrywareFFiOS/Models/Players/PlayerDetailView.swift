//
//  PlayerDetailView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/3/25.
//

import SwiftUI

struct PlayerDetailView: View {
    
    var playerDetail: PlayerInfo
    
    var body: some View {
        let headshotURL: URL! = URL(string: playerDetail.playerHeadshot)!
        AsyncImage(url: headshotURL)
            .frame(width: 200, height: 200)
        Text(playerDetail.playerName)
        Text(playerDetail.playerTeam)
    }
}

#Preview {
    let playerDetail: PlayerInfo = .init(
        id: "7700",
        playerSeasonKey: "449.p.7200",
        playerName: "Aaron Rogers",
        playerUrl: "https://sports.yahoo.com/nfl/players/7200)",
        playerTeam: "Pittsburgh Steelers",
        playerByeWeek: 4,
        playerUniformNumber: 12,
        playerPosition: "QB",
        playerHeadshot: "https://s.yimg.com/iu/api/res/1.2/8MiUmLsQnH2U8RAK8U0goA--~C/YXBwaWQ9eXNwb3J0cztjaD0yMzM2O2NyPTE7Y3c9MTc5MDtkeD04NTc7ZHk9MDtmaT11bGNyb3A7aD02MDtxPTEwMDt3PTQ2/https://s.yimg.com/xe/i/us/sp/v/nfl_cutout/players_l/09092024/7200.png"
        )
    PlayerDetailView(playerDetail: playerDetail)
}
