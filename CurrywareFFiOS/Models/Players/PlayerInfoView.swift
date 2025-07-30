//
//  PlayerInfoView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 7/27/25.
//

import SwiftUI

struct PlayerInfoView: View {
    
    @StateObject var playerModel = PlayerInfoHandler()
    // @State private var playerInfo: [PlayerInfo] = []
    //let playerInfo: [PlayerInfo]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(playerModel.playerInfoList) { playerInfo in
                    Text(playerInfo.playerName)
                }
            }
            .task {
                await playerModel.getPlayerInfoList()
            }
        }
    }
}
    
struct PlayerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerInfoView()
    }
}
