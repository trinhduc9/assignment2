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
    @State var soundEffect = UserDefaults.standard.bool(forKey: "SoundEffectEnableUD")
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @Binding var lang: String
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
                    Text("Instructions")
                }
            LeaderboardView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Leaderboard")
                }
            StatsView(lang: $lang)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Stats")
                }
            SettingView(lang: $lang)
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
        .environment(\.colorScheme, isDark ? .dark : .light)
        .environment(\.locale, .init(identifier: lang))
    }
}

struct TabDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        TabDisplayView(lang: $lang)
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
