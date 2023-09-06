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

struct WelcomeView: View {

    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("Language") var lang: String = "en"
    @State private var username: String = ""
    @Binding var soundEnable: Bool
    @Binding var soundEffect: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image("mineEntranceLogo")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    //Textfield for user to enter username
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 250)
    
                    Spacer()
                    Button(action: {
                        if let loadedUserData = loadSingleUserData(forUsername: username) {
                            userData.username = loadedUserData.username
                            userData.gamePlayed = loadedUserData.gamePlayed
                            userData.balance = loadedUserData.balance
                            userData.totalBet = loadedUserData.totalBet
                            userData.totalWinning = loadedUserData.totalWinning
                            userData.profitLoss = loadedUserData.profitLoss
                            userData.achievements = loadedUserData.achievements
                            userData.currentGame = loadedUserData.currentGame
                        } else {
                            userData.username = username
                        }
                    }) {
                        Text("Start Mining")
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .font(.headline)
                            .cornerRadius(10)
                    }
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
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        WelcomeView(soundEnable: .constant(true), soundEffect: .constant(true))
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
