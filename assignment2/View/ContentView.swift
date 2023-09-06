/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
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

struct ContentView: View {

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("Language") var lang: String = "en"
    @State var soundEnable = UserDefaults.standard.bool(forKey: "SoundEnableUD")
    @State var soundEffect = UserDefaults.standard.bool(forKey: "SoundEffectEnableUD")
    
    var body: some View {
        ZStack {
            if userData.username == "" {
                //Welcome view for user to enter username
                WelcomeView(soundEnable: $soundEnable, soundEffect: $soundEffect)
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
                    .environment(\.locale, .init(identifier: lang))
            }else{
                //Main view for user to start playing
                TabDisplayView(soundEnable: $soundEnable, soundEffect: $soundEffect)
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
        ContentView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
    }
}
