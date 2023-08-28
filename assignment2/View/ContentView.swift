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
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @Binding var lang: String
    var body: some View {
        ZStack {
            if userData.username == "" {
                WelcomeView(lang: $lang)
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
                    .environment(\.locale, .init(identifier: lang))
            }else{
                TabDisplayView(lang: $lang)
                    .environment(\.locale, .init(identifier: lang))
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        ContentView(lang: $lang)
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
