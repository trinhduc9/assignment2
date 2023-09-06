/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 21/08/2023
 Last modified: 21/08/2023
 Acknowledgement:
-   https://www.youtube.com/watch?v=VYxxzrlS8q0
-   https://www.youtube.com/watch?v=aJ9kKX6Ak3k
-	https://kowei-chen.medium.com/swiftui-dynamic-localization-tricks-87c37a6db3e7
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-provide-relative-sizes-using-geometryreader
-	https://stackoverflow.com/questions/62372188/how-to-use-userdata-observable-object-in-swiftui
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-disable-taps-for-a-view-using-allowshittesting
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-menu-when-a-button-is-pressed
-	https://developer.apple.com/documentation/swiftui/picker
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
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
