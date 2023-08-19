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
    @State private var pickedNumber = 1
    @State private var cards: [Card] = []
    @State private var disableUserInteraction = true
    @State private var disableGameSetting = false
    @AppStorage("DarkMode") private var isDark : Bool = false
    
    init() {
        _cards = State(initialValue: createList(bombNo: pickedNumber))
    }
   

    var body: some View {
        VStack{
            HStack{
                
                Text("Mines")
            }
            GameView(cards: cards, disableUserInteraction: $disableUserInteraction, disableGameSetting: $disableGameSetting)
                .environmentObject(UserData.shared)
            GameSettingView(pickedNumber: $pickedNumber, cards: $cards, disableUserInteraction: $disableUserInteraction, disableGameSetting: $disableGameSetting)
                .environmentObject(UserData.shared)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
