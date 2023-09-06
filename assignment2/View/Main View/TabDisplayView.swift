/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 15/08/2023
 Last modified: 05/09/2023
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
import UIKit

//The main view to display all view
struct TabDisplayView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("DarkMode") private var isDark: Bool = false
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @AppStorage("Language") var lang: String = "en"
    @Binding var soundEnable: Bool
    @Binding var soundEffect: Bool
    
    var body: some View {
        TabView {
            MainView(soundEnable: $soundEnable, soundEffect: $soundEffect)
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Game")
                }
            InstructionView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Instructions")
                }
            LeaderboardView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Leaderboard")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Stats")
                }
            SettingView(soundEnable: $soundEnable, soundEffect: $soundEffect)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .onAppear{
            if soundEnable{
                audioManager.playBackgroundMusic(fileName: "backgroundMusic", loops: true)
            }
        }
        .onDisappear{
            audioManager.stopSound()
        }
        .accentColor(isDark ? .white : .black)
        .environmentObject(UserData.shared)
        .environmentObject(audioManager)
        .environment(\.colorScheme, isDark ? .dark : .light) //Pass colorscheme into environment
        .environment(\.locale, .init(identifier: lang))
    }
}

struct TabDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        TabDisplayView(soundEnable: .constant(true), soundEffect: .constant(true))
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
