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

struct CardView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var card:Card
    let width: Int
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    
    var body: some View {
        VStack{
            if card.isFaceUp{
                Text(card.text)
                    .font(.system(size: 50))
                    .padding()
                    .frame(width: CGFloat(width), height: CGFloat(width))
                    .background(Color(.lightGray))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.black), lineWidth: 3)
                    )
                    .transition(.opacity)
            } else {
                Image(systemName: "questionmark.diamond.fill")
                    .font(.system(size: CGFloat(width/2)))
                    .padding()
                    .frame(width: CGFloat(width), height: CGFloat(width))
                    .background(Color(.lightGray))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.black), lineWidth: 3)
                    )
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.3)){
                            card.turnCard()
                            print(card.isFaceUp)
                            userData.updateCard(card: card)
                            checkCard(card: card)
                        }
                    }
            }
            Text("isFaceUp: \(card.isFaceUp ? "true" : "false")")
        }
    }
    
    
    func checkCard(card: Card){
        if card.text == "💣"{
            disableUserInteraction = true
            disableGameSetting = false
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(text: "💣")
        CardView(card: card, width: 100)
    }
}
