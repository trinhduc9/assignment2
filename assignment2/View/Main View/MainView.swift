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

struct MainView: View {
    
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var userData: UserData
    @State private var cards: [Card] = createList(bombNo: 1)
    @AppStorage("CurrentMines") private var pickedNumber: Int = 1
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("DarkMode") private var isDark : Bool = false
    @State var soundEnable = UserDefaults.standard.bool(forKey: "SoundEnableUD")
    @State var soundEffect = UserDefaults.standard.bool(forKey: "SoundEffectEnableUD")
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @State private var keyboardHeight: CGFloat = 0.0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("$\(String(format: "%.2f", userData.balance))")
                Image(systemName: "dollarsign.circle")
                    .foregroundColor(.yellow)
                    .padding([.trailing], 5)
            }
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
            )
            Spacer()
            ZStack{
                GameView(cards: cards)
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
                Spacer()
                if gameEnded {
                    GameEndView(isLoss: $isLoss)
                }
            }
            GameSettingView(gameEnded: $gameEnded, isLoss: $isLoss, cards: $cards)
                .environmentObject(UserData.shared)
                .environmentObject(audioManager)
            Spacer()
        }
        .background(Color("backgroundcolor"))
        .onAppear {
            let storedGame = userData.currentGame
            
            if !storedGame.isEmpty {
                cards = storedGame
            } else {
                cards = createList(bombNo: 1)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
    }
}
