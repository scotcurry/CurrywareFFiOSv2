//
//  InitialContent.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/27/24.
//

import SwiftUI

struct InitialContent: View {
    
    let league: LeagueSelectionModel
    
    var body: some View {
                
        TabView {
            
            PlayerInfoListView()
                .tabItem {
                    Label("Players", systemImage: "house.fill")
                }
            
//            LeagueSettingsView(leagueSettings: leagueSettings)
//                .tabItem {
//                    Label("Pass Settings", systemImage: "figure.american.football")
//                }
            
            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun")
                }
        }
    }
}

struct InitialContentView_Previews: PreviewProvider{
    
    static var leagueSettings = LeagueSelectionModel(league_id: "1", game_id: "461", team_name: "Datadog 2025", paid_league: true)
    
    static var previews: some View {
        InitialContent(league: leagueSettings)
    }
}
