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
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @State private var username: String = ""
    

    var body: some View {
        VStack{
            Image("applogo")
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button(action: {
                if let loadedUserData = loadSingleFromFile(forUsername: username) {
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
                Text("Continue")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
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
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
    }
}
