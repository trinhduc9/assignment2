/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 15/08/2023
 Last modified: 23/08/2023
 Acknowledgement:
 */


import SwiftUI
import UIKit

struct TabDisplayView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("DarkMode") private var isDark: Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
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
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .onAppear{
            if soundEnable{
                audioManager.playSound(fileName: "backgroundMusic", loops: true)
            }
            UITabBar.appearance().barTintColor = UIColor.red // Set tab bar background color
            UITabBar.appearance().tintColor = UIColor.blue // Set tab bar tint color
        }
        .onDisappear{
            audioManager.stopSound()
        }
        .accentColor(Color.black)
        .environmentObject(UserData.shared)
        .environmentObject(audioManager)
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct TabDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        TabDisplayView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
    }
}
