//
//  AchievementCardView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 21/08/2023.
//

import SwiftUI

struct AchievementCardView: View {
    
    var achievement: Achievement
    
    var body: some View {
        HStack(alignment: .top){
            Image(achievement.badge)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 10){
                Text(achievement.name)
                    .font(.system(size: 20))
                    .bold()
                    .alignmentGuide(.leading, computeValue: {
                        dimension in dimension[.leading]})
                Text(achievement.description)
            }
        }
    }
}

struct AchievementCardView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCardView(achievement: achievements[0])
    }
}
