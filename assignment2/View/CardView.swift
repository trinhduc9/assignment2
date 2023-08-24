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

struct CardView: View {
    
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var userData: UserData
    @ObservedObject var card:Card
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("CurrentGemCount") private var count: Int = 0
    @State private var rotation: Double = 0
    @State private var animating = true
    let width: Int
    
    var body: some View {
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
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                .onTapGesture {
                    withAnimation(.linear(duration: 0.3)){
                        rotating()
                        userData.updateCard(card: card)
                        checkCard(card: card)
                    }
                }
        }
    }
    
    func checkCard(card: Card){
        if card.text == "💣"{
            disableUserInteraction = true
            disableGameSetting = false
            count = 0
            audioManager.playSound(fileName: "bombExplode", loops: false)
        }else{
            audioManager.playSound(fileName: "placeBet", loops: false)
           
            count += 1
        }
    }
    func rotating(){
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if self.animating {
                withAnimation(Animation.linear(duration: 0.1)) {
                    self.rotation += 3
                }
                if self.rotation == 90 || self.rotation == 270  {
                    card.turnCard()
                }
                if self.rotation == 360 || self.rotation == 180 {
                    self.animating = false
                }
                if self.rotation == 180 {
                    self.rotation = 0
                }
            }
        }
        self.animating = true
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(text: "💣")
        CardView(card: card, width: 100)
            .environmentObject(AudioManager())
    }
}
