/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 15/08/2023
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

struct MainView: View {
    
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var userData: UserData
    @AppStorage("Language") var lang: String = "en"
    @AppStorage("CurrentMines") private var pickedNumber: Int = 1
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("DarkMode") private var isDark : Bool = false
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @State private var cards: [Card] = []
    @State private var keyboardHeight: CGFloat = 0.0
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var timer: Timer? = nil
    @Binding var soundEnable: Bool
    @Binding var soundEffect: Bool
    
    var body: some View {
        GeometryReader{ geo in
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
                    //The game interaction view
                    GameView(soundEnable: $soundEnable, soundEffect: $soundEffect, cards: cards)
                        .environmentObject(UserData.shared)
                        .environmentObject(audioManager)
                    Spacer()
                    if gameEnded { //Display winning/losing screen
                        GameEndView(isLoss: $isLoss)
                            .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.7)
                            .onAppear{
                                //Start timer so that the game end only appear for 5seconds
                                timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                                    gameEnded = false
                                }
                            }
                    }
                }
                //Game setting view
                GameSettingView(soundEnable: $soundEnable, soundEffect: $soundEffect, cards: $cards)
                    .environmentObject(UserData.shared)
                    .environmentObject(audioManager)
                Spacer()
            }
            .background(Color("backgroundcolor"))
            .onAppear { //Load initial card list
                let storedGame = userData.currentGame
                if !storedGame.isEmpty {
                    cards = storedGame
                } else {
                    cards = createList(bombNo: 1)
                }
            }
        }
    }
}

/*struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(soundEnable: .constant(true), soundEffect: .constant(true), cards: createList(bombNo: <#T##Int#>))
            .environmentObject(UserData.shared)
            .environmentObject(AudioManager())
    }
}*/
