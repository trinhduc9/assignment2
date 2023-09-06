/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 21/08/2023
 Last modified: 25/08/2023
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

struct AchievementView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("DarkMode") private var isDark: Bool = false

    var body: some View {
        VStack {
            List {
                Section(header: Text("Unlocked Achievements")
                    .foregroundColor(isDark ? .white : .black)
                    .font(.headline)
                    .padding(.top)){
                        ForEach(userData.achievements.indices, id: \.self) { index in
                            if userData.achievements[index] == true {
                                AchievementCardView(achievement: achievements[index])
                                    .listRowBackground(Color("lightgray"))
                            }
                        }
                    }
                
                Section(header: Text("Locked Achievements")
                    .foregroundColor(isDark ? .white : .black)
                    .font(.headline)
                    .padding(.top)){
                        ForEach(userData.achievements.indices, id: \.self) { index in
                            if userData.achievements[index] == false {
                                AchievementCardView(achievement: achievements[index])
                                    .listRowBackground(Color("lightgray"))
                            }
                        }
                    }
            }
            .listStyle(GroupedListStyle())
            .scrollContentBackground(.hidden)
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
            .environmentObject(UserData.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        AchievementView()
            .environmentObject(UserData.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    
    }
}
