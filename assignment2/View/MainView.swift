/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 15/08/2023
 Last modified:
 Acknowledgement:
 */


import SwiftUI

struct MainView: View {
    
    
    @EnvironmentObject var userData: UserData
    @State private var cards: [Card] = createList(bombNo: 1)
    @AppStorage("CurrentMines") private var pickedNumber: Int = 1
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("DarkMode") private var isDark : Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Mines")
            }
            GameView(cards: cards)
                .environmentObject(UserData.shared)
            GameSettingView(cards: $cards)
                .environmentObject(UserData.shared)
        }
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

/*struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserData.shared)
    }
}*/
