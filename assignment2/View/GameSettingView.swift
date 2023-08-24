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

struct GameSettingView: View {
    
    @EnvironmentObject var audioManager: AudioManager
    @EnvironmentObject var userData: UserData
    @Binding var cards: [Card]
    @AppStorage("CurrentBet") var inputText: String = ""
    @AppStorage("CurrentMines") private var pickedNumber: Int = 1
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("DisableGS") private var disableGameSetting: Bool = false
    @AppStorage("DarkMode") private var isDark:Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("Multiplier") var multiplier: Double = 0.0
    @AppStorage("DiamondCount") var count: Int = 0
    @AppStorage("Winning") var winning: Double = 0.0
    
    var body: some View {

            VStack(spacing: 20) {
                if disableGameSetting{
                HStack{
                    Text("Multiplier: \(String(format: "%.2f", multiplier))")

                    Text("Profit: \(String(format: "%.2f", winning - Double(inputText)!))")
                }
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Bet Amount")
                            .font(.headline)
                            .foregroundColor(isDark ? .white : .black)
                        ZStack(alignment: .trailing) {
                            TextField("Amount", text: $inputText)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                /*.onChange(of: inputText) { newValue in
                                    if let value = Double(newValue) {
                                        let formattedValue = String(format: "%.2f", value)
                                        if formattedValue != newValue {
                                            inputText = formattedValue
                                        }
                                    } else if !newValue.isEmpty {
                                        inputText = String(newValue.dropLast())
                                    }
                                }*/
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.green)
                                .padding([.trailing], 5)
                        }
                    }
                    .frame(maxWidth: .infinity) // Equal width for both VStacks
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Mines")
                            .font(.headline)
                            .foregroundColor(isDark ? .white : .black)
                        Menu {
                            ForEach(1..<16) { number in
                                Button(action: {
                                    pickedNumber = number
                                }) {
                                    Text("\(number)")
                                        .foregroundColor(isDark ? .white : .black)
                                        .frame(maxWidth: .infinity, alignment: .leading) // Match the Picker's width
                                        .padding(.horizontal, 16) // Adjust horizontal padding
                                }
                            }
                        } label: {
                            HStack {
                                Text("\(pickedNumber)")
                                    .foregroundColor(isDark ? .white : .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 16)
                                    .frame(height: 31)
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(isDark ? .white : .black)
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
                .frame(height: 100)
                .padding(.horizontal)
                //.background(Color(hue: 1.0, saturation: 0.0, brightness: 0.093))
                .background(Color(hue: 1.0, saturation: 0.024, brightness: 0.96))
                .cornerRadius(15)
                .allowsHitTesting(!disableGameSetting)
                HStack{
                    Button(action: {
                        if !inputText.isEmpty && Float(inputText) != nil{

                            cards = createList(bombNo: pickedNumber)
                            userData.currentGame = cards
                            userData.saveCurrentGame(game: cards)
                            disableUserInteraction = false
                            disableGameSetting = true
                            userData.updateTotalBet(bet: Double(inputText)!)
                            userData.updateBalance(balance: -Double(inputText)!)
                            userData.updategamePlayed()
                            
                        }
                    }) {
                        Text("Start Game")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isDark ? .white : .black)
                    .foregroundColor(isDark ? .black : .white)
                    .cornerRadius(10)
                    .allowsHitTesting(!disableGameSetting)
                    if disableGameSetting{
                        Button("Cash Out"){
                            cashOut()
                            disableUserInteraction = true
                            disableGameSetting = false
                            pickedNumber = 1
                            count = 0
                            audioManager.playSound(fileName: "cashout", loops: false)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isDark ? .white : .black)
                        .foregroundColor(isDark ? .black : .white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding() // Add padding to the whole VStack
            //.background(Color(hue: 1.0, saturation: 0.026, brightness: 0.154))
            .background(Color(hue: 1.0, saturation: 0.021, brightness: 0.889))
            .cornerRadius(15) // Add corner radius
        }
    
    func cashOut(){
        userData.updateBalance(balance: Double(inputText)! * multiplier)
        userData.updateTotalWinning(winning: Double(inputText)! * multiplier)
        userData.updateProfitLoss(profitLoss: Double(inputText)! * multiplier)
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
            GameSettingView( cards: cards)
                .environmentObject(AudioManager())
        }
    }
}
