//
//  InitialContent.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/27/24.
//

import SwiftUI

struct InitialContent: View {
    
    let leagueList: [LeagueList]
    let leagueSettings: [LeagueSetting]
    
    var body: some View {
        
        TabView {
            
            LeagueSelectionView(leagueList: leagueList)
                .tabItem {
                    Label("Selector", systemImage: "house.fill")
                }
            
            LeagueSettingsView(leagueSettings: leagueSettings)
                .tabItem {
                    Label("Pass Settings", systemImage: "figure.american.football")
                }
            
            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun")
                }
        }
    }
}

struct InitialContentView_Previews: PreviewProvider{
    
    static var leagueList = LeagueList.leagueData
    static var leagueSettings = LeagueSetting.sampleData
    
    static var previews: some View {
        InitialContent(leagueList: leagueList, leagueSettings: leagueSettings)
    }
}
