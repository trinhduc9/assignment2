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
 - https://www.youtube.com/watch?v=aJ9kKX6Ak3k
 */


import SwiftUI

struct ContentView: View {

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("Language") var lang: String = "en"
    @State var soundEnable = UserDefaults.standard.bool(forKey: "SoundEnableUD")
    @State var soundEffect = UserDefaults.standard.bool(forKey: "SoundEffectEnableUD")
    
    var body: some View {
        ZStack {
            if userData.username == "" {
                WelcomeView(soundEnable: $soundEnable, soundEffect: $soundEffect)
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
                    .environment(\.locale, .init(identifier: lang))
            }else{
                TabDisplayView(soundEnable: $soundEnable, soundEffect: $soundEffect)
                    .environment(\.locale, .init(identifier: lang))
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
            }
        }
        .onAppear {
            soundEnable = true
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        ContentView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        ContentView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
        
        ContentView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        ContentView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation) "))
            .previewDisplayName("iPad Pro 11")
    }
}
