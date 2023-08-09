//
//  LeagueSettingCardView.swift
//  CurrywareFFiOS
//
//  Created by Scot Curry on 8/5/23.
//

import SwiftUI

struct LeagueSettingCardView: View {
    
    let leagueSetting: LeagueSetting
    
    var body: some View {
        VStack(alignment: .center) {
            Label("\(leagueSetting.statName)", systemImage: "figure.american.football")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Text("Group: \(leagueSetting.statGroup)")
                Spacer()
                Text("Value: \(leagueSetting.statValue, specifier: "%.2f")")
            }
            HStack {
                Text("Bonus Target: \(leagueSetting.statBonusTarget)")
                Spacer()
                Text("Bonus Value: \(leagueSetting.statBonusPoints)")
            }
            .font(.caption)
        }
        .padding()
    }
}

struct LeagueSettingCardView_Previews: PreviewProvider {
    
    static var leagueSetting = LeagueSetting.sampleData[0]
    static var previews: some View {
        LeagueSettingCardView(leagueSetting: leagueSetting)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
