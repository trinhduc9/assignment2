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
        ZStack{
            Image("mineEntranceLogo")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
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

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        WelcomeView(soundEnable: .constant(true), soundEffect: .constant(true))
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
