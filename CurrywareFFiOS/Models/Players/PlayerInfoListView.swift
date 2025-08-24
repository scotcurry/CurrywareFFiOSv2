//
//  PlayerInfoView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 7/27/25.
//

import SwiftUI

struct PlayerInfoListView: View {
    
    @StateObject var playerModel = PlayerInfoHandler()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(playerModel.playerInfoList) { playerInfo in
                    NavigationLink(playerInfo.playerName) {
                        PlayerDetailView(playerDetail: playerInfo)
                    }
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
        let playerInfoHandler = PlayerInfoHandler()
        PlayerInfoListView(playerModel: playerInfoHandler)
    }
}
