/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 23/08/2023
 Acknowledgement:
- https://medium.com/@amitsrivastava115/toggle-between-dark-and-light-mode-in-swiftui-across-whole-app-5ccfc06a8eca
- https://replit.com/@playful/Stakecom-Mines-Multiplier-calculator#main.py
- https://kowei-chen.medium.com/swiftui-dynamic-localization-tricks-87c37a6db3e7
 */

import SwiftUI

@main
struct assignment2App: App {
    
    @StateObject private var userData = UserData()
    @StateObject private var audioManager = AudioManager()
    @State var soundEnable = UserDefaults.standard.bool(forKey: "SoundEnableUD")
    @State var soundEffect = UserDefaults.standard.bool(forKey: "SoundEffectEnableUD")
    @AppStorage("Language") var lang: String = "en"

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData.shared)
                .environmentObject(audioManager)
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
