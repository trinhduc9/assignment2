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
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Game")
                }
                .environmentObject(UserData.shared)
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
                    Image(systemName: "")
                    Text("Stats")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Settings")
                }
        }
    }
}

struct TabDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        TabDisplayView()
    }
}
