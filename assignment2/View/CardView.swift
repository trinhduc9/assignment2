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
    @AppStorage("SoundEffectEnable") private var soundEffect: Bool = true
    @AppStorage("CurrentBet") var inputText: String = ""
    @AppStorage("CurrentMines") var pickedNumber: Int = 1
    @AppStorage("Multiplier") var multiplier: Double = 0.0
    @AppStorage("DiamondCount") var count: Int = 0
    @AppStorage("Winning") var winning: Double = 0.0
    @State private var rotation: Double = 0
    @State private var animating = true
    let width: Int
    
    var body: some View {
        if card.isFaceUp{
            Text(card.text)
                .font(.system(size: CGFloat(width/2)))
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color("lightgray"))
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
                .foregroundColor(Color("bluepurp"))
                .background(Color("lightgray"))
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
            audioManager.playSound(fileName: "bombExplode", loops: false)
        }else{
            count += 1
            multiplier = calculateMultiplier(mines: pickedNumber, diamonds: count)
            winning = Double(inputText)! * multiplier
            audioManager.playSound(fileName: "gemFound", loops: false)
            if count == 16 - pickedNumber{
                userData.updateBalance(balance: (Double(inputText)! * multiplier).rounded(to: 2))
                userData.updateTotalWinning(winning: (Double(inputText)! * multiplier - Double(inputText)!).rounded(to: 2))
                userData.updateProfitLoss(profitLoss: (Double(inputText)! * multiplier).rounded(to: 2))
                if userData.achievements[0] == false && userData.totalWinning >= 50000.00 {
                    userData.updateAchievement(index: 0)
                }
                if userData.achievements[1] == false && userData.totalWinning >= 100000.00 {
                    userData.updateAchievement(index: 1)
                }
                if userData.achievements[2] == false && userData.totalWinning >= 200000.00{
                    userData.updateAchievement(index: 2)
                }
                if userData.achievements[3] == false {
                    userData.updateAchievement(index: 3)
                }
                if userData.achievements[4] == false && pickedNumber == 15 {
                    userData.updateAchievement(index: 4)
                }
                disableUserInteraction = true
                disableGameSetting = false
                pickedNumber = 1
                inputText = ""
            }
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
