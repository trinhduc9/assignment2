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

struct GameView: View {
    
    @EnvironmentObject var userData: UserData
    var fourColumnGrid = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
    
    var cards: [Card]
    @Binding var disableUserInteraction: Bool
    @Binding var disableGameSetting: Bool
    
    var body: some View {
        GeometryReader{geo in
            LazyVGrid(columns: fourColumnGrid, spacing: 10){
                ForEach(cards){ card in
                    CardView(card: card,
                             width: Int(geo.size.width/4 - 10),
                             disableUserInteraction: $disableUserInteraction, disableGameSetting: $disableGameSetting)
                }
            }.padding(.horizontal)
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
                GameView(cards: cards, disableUserInteraction: .constant(false), disableGameSetting: .constant(false))
            }
        }
}
