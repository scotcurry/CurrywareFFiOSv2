//
//  LeagueSettingsView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import SwiftUI

struct LeagueSettingsView: View {
    
    @StateObject private var leagueSettingsList = LeagueSettingList()
    @State private var passingYards: String = ""
    @State private var passingTds: String = ""
    @State private var totalPoints: String = ""
    
    let leagueSettings: [LeagueSetting]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0.5) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            List(leagueSettings, id: \.id) { leagueSetting in
                LeagueSettingCardView(leagueSetting: leagueSetting)
            }
            .padding(.bottom)
            
            HStack {
                Text("Passing Yards")
                TextField("yds", text: $passingYards)
            }
            .padding(.leading)
            
            Spacer()
            
            HStack {
                Text("Touchdowns")
                TextField("TD's", text: $passingTds)
            }
            .padding(.leading)
            Button("Calculate Total") {
                let passingYardsValue: Float = 0.04
                let passingYardsFloat = Float(passingYards)
                let newPassingPoints = passingYardsFloat! * passingYardsValue
                
                let passingTdValue: Float = 4.0
                let passingTdFloat = Float(passingTds)
                let tdTotal = passingTdValue * passingTdFloat!
                
                let newGrandTotal = newPassingPoints + tdTotal
                
                totalPoints = String(format: "%.2f", newGrandTotal)
            }
            .padding(.bottom)
            Spacer()
            
            HStack {
                Text("Total Points")
                Text(totalPoints)
            }
            .padding(.bottom)
            
            Spacer()
            .padding(.bottom)
        }
    }
}

struct LeagueSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueSettingsView(leagueSettings: LeagueSetting.sampleData)
    }
}
