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

struct GameView: View {
    
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var userData: UserData
    @AppStorage("Language") var lang: String = "en"
    @AppStorage("DarkMode") private var isDark : Bool = false
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @Binding var soundEnable: Bool
    @Binding var soundEffect: Bool
    var fourColumnGrid = [GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())]
    
    var cards: [Card]
    
    var body: some View {
        GeometryReader{geo in
            //Display cards in grid of 4 columns
            LazyVGrid(columns: fourColumnGrid, spacing: 10){
                ForEach(cards){ card in
                    CardView(card: card, soundEnable: $soundEnable, soundEffect: $soundEffect, 
                             width: Int(geo.size.width/4 - 10))
                        .environmentObject(UserData.shared)
                        .environmentObject(audioManager)
                }
            }
            .padding(10)
            .border(.black, width: 2)
            .padding(.horizontal, -2)
            .allowsHitTesting(!disableUserInteraction)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
            let cards_p = createList(bombNo: 4).shuffled()
            return PreviewWrapper(cards: cards_p)
        }
        
        struct PreviewWrapper: View {
            let cards: [Card]
            
            var body: some View {
                GameView(soundEnable: .constant(true), soundEffect: .constant(true), cards: cards)
            }
        }
}
