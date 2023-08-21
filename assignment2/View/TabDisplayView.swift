/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 15/08/2023
 Last modified:
 Acknowledgement:
 */


import SwiftUI

struct TabDisplayView: View {
    
    @EnvironmentObject var userData: UserData
    @AppStorage("DarkMode") private var isDark : Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Game")
                }
            InstructionView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Instruction")
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
            SettingView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Settings")
                }
        }.environmentObject(UserData.shared)
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct TabDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        TabDisplayView()
            .environmentObject(UserData.shared)
    }
}
