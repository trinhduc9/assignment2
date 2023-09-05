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
import UIKit

struct GameSettingView: View {
    
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var userData: UserData
    @AppStorage("CurrentBet") var inputText: String = ""
    @AppStorage("CurrentMines") private var pickedNumber: Int = 1
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("DarkMode") private var isDark:Bool = false
    @AppStorage("Multiplier") var multiplier: Double = 1.0
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @AppStorage("DiamondCount") var count: Int = 0
    @State private var showAlert = false
    @Binding var soundEnable: Bool
    @Binding var soundEffect: Bool
    @Binding var cards: [Card]
    let decimalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter
        }()
    var body: some View {
        VStack(spacing: 10) {
            if disableGameSetting{
                HStack{
                    Text("Profit")
                        .foregroundColor(isDark ? .black : .white)
                    Text("(\(String(format: "%.2f", multiplier))): \(String(format: "%.2f", (Double(inputText)! * multiplier)-Double(inputText)!))")
                        .foregroundColor(isDark ? .black : .white)
                    
                }
            }
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Bet Amount")
                        .font(.headline)
                        .foregroundColor(.black)
                    ZStack(alignment: .trailing) {
                        TextField("", text: $inputText)
                            .placeholder(when: inputText.isEmpty) {
                                Text("Amount")
                                    .foregroundColor(.black)
                                    .opacity(0.5)
                            }
                            .keyboardType(.decimalPad)
                            .padding(5)
                            .background(.white)
                            .foregroundColor(.black)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.black, lineWidth: 1)
                            )
                            .cornerRadius(8)
                            .onChange(of: inputText) { newValue in
                                // Ensure that the input has at most two decimal places
                                if let decimalIndex = newValue.firstIndex(of: ".") {
                                    let decimalCount = newValue.distance(from: decimalIndex, to: newValue.endIndex)
                                    if decimalCount > 3 {
                                        // Truncate input to two decimal places
                                        if let range = newValue.range(of: #"^\d+\.\d{0,2}"#, options: .regularExpression) {
                                            inputText = String(newValue[range])
                                        }
                                    }
                                }
                            }
                        Image(systemName: "dollarsign.circle")
                            .foregroundColor(.green)
                            .padding([.trailing], 5)
                    }
                }
                .frame(maxWidth: .infinity) // Equal width for both VStacks
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Mines")
                        .font(.headline)
                        .foregroundColor(.black)
                    Menu {
                        ForEach(1..<16) { number in
                            Button(action: {
                                pickedNumber = number
                            }) {
                                Text("\(number)")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading) // Match the Picker's width
                                    .padding(.horizontal, 16) // Adjust horizontal padding
                            }
                        }
                    } label: {
                        HStack {
                            Text("\(pickedNumber)")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                                .frame(height: 31)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .labelsHidden()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black, lineWidth: 1) // Border color and width
                    )
                    
                }
                .frame(maxWidth: .infinity) // Equal width for both VStacks
            }
            .frame(height: 80)
            .padding(.horizontal)
            .background(Color("lightgray"))
            .cornerRadius(15)
            .allowsHitTesting(!disableGameSetting)
            HStack{
                Button(action: {
                    if !inputText.isEmpty && Float(inputText) != nil{
                        gameEnded = false
                        isLoss = false
                        cards = createList(bombNo: pickedNumber)
                        userData.currentGame = cards
                        userData.saveCurrentGame(game: cards)
                        disableUserInteraction = false
                        disableGameSetting = true
                        userData.updateTotalBet(bet: Double(inputText)!)
                        userData.updateBalance(balance: -Double(inputText)!)
                        userData.updateProfitLoss(profitLoss: -Double(inputText)!)
                        userData.updategamePlayed()
                        multiplier = 1.0
                        count = 0
                    }else{
                        showAlert.toggle()
                    }
                }) {
                    Text("Start Game")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("lightblack"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .opacity(disableGameSetting ? 0.3 : 1)
                .allowsHitTesting(!disableGameSetting)
                if disableGameSetting{
                    Button("Cash Out"){
                        gameEnded = true
                        appendHighscoreLocal(name: userData.username, winning: (Double(inputText)! * multiplier).rounded(to: 2))
                        cashOut()
                        disableUserInteraction = true
                        disableGameSetting = false
                        if soundEffect {
                            audioManager.playSoundEffect(fileName: "cashout")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("lightblack"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $showAlert) {
            CustomAlertView(isPresented: $showAlert, title: "ERROR", message: "Invalid amount of money")
        }
        .padding() // Add padding to the whole VStack
        .background(Color("bluepurp"))
        .cornerRadius(15) // Add corner radius
    }
    
    func cashOut(){
        userData.updateBalance(balance: (Double(inputText)! * multiplier).rounded(to: 2))
        userData.updateTotalWinning(winning: (Double(inputText)! * multiplier).rounded(to: 2))
        userData.updateProfitLoss(profitLoss: (Double(inputText)! * multiplier - Double(inputText)!).rounded(to: 2))
        if userData.achievements[0] == false && userData.totalWinning >= 50000.00 {
            userData.updateAchievement(index: 0)
        }
        if userData.achievements[1] == false && userData.totalWinning >= 100000.00 {
            userData.updateAchievement(index: 1)
        }
        if userData.achievements[2] == false && userData.totalWinning >= 200000.00{
            userData.updateAchievement(index: 2)
        }
    }
}


struct GameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let cards_p = createList(bombNo: 4).shuffled()
        return PreviewWrapper(cards:  Binding.constant(cards_p))

    }
    
    struct PreviewWrapper: View {
        let cards: Binding<[Card]>
        
        var body: some View {
            GameSettingView(soundEnable: .constant(true), soundEffect: .constant(true), cards: cards)
                .environmentObject(AudioManager())
                .preferredColorScheme(.dark)
        }
    }
}
