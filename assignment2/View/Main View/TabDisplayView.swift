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
    @AppStorage("SoundEffectEnable") private var soundEffect: Bool = true
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
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
                        .foregroundColor(isDark ? .white : .black)
                    Text("Instructions")
                        .foregroundColor(isDark ? .white : .black)
                }
            LeaderboardView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Leaderboard")
                }.foregroundColor(isDark ? .white : .black)
            StatsView(lang: $lang)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Stats")
                }.foregroundColor(isDark ? .white : .black)
            SettingView(lang: $lang)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
        .onAppear{
            if soundEnable{
                audioManager.playSound(fileName: "backgroundMusic", loops: true)
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
