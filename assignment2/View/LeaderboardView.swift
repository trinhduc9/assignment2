/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified:
 Acknowledgement:
 */

import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var userData = UserData.shared
    
    var body: some View {
        VStack {
            Text("Balance:")
            Text("$\(String(format: "%.2f", userData.balance))")
            Text("Current Game:")
                .font(.headline)
            
            List(userData.currentGame, id: \.id) { card in
                HStack {
                    Text("Card ID: \(card.id)")
                    Spacer()
                    Text("Face Up: \(card.isFaceUp ? "Yes" : "No")")
                }
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
