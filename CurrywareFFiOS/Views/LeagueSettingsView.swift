//
//  LeagueSettingsView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import SwiftUI

struct LeagueSettingsView: View {
    
    @StateObject private var leagueSettingsList = LeagueSettingList()
    
    let leagueSettings: [LeagueSetting]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            List(leagueSettings, id: \.id) { leagueSetting in
                LeagueSettingCardView(leagueSetting: leagueSetting)
            }
        }
    }
}

struct LeagueSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSettingsView(leagueSettings: LeagueSetting.sampleData)
    }
}
