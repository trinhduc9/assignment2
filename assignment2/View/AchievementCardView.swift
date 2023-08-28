/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 21/08/2023
 Last modified:
 Acknowledgement:
 */

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
            }.foregroundColor(.black)
        }
    }
}

struct AchievementCardView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCardView(achievement: achievements[0])
    }
}
