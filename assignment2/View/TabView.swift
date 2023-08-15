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

struct TabView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem{
                    Image(systemName: "")
                    Text("Game")
                }
            InstructionView(){
                .tabItem{
                    Image(systemName: "")
                    Text("Instruction")
                }
            }
            LeaderboardView()
                .tabItem{
                    Image(systemName: "")
                    Text("Leaderboard")
                }
            SettingView()
                .tabItem{
                    Image(systemName: "")
                    Text("Settings")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
