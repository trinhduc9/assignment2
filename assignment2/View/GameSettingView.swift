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

struct GameSettingView: View {
    
    @State var inputText: String = ""
    @Binding var pickedNumber: Int
    @Binding var cards: [Card]
    @Binding var disableUserInteraction: Bool
    @Binding var disableGameSetting: Bool
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Bet Amount")
                        .font(.headline)
                        .foregroundColor(.blue)
                    ZStack(alignment: .trailing) {
                        TextField("Amount", text: $inputText)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Image(systemName: "dollarsign.circle")
                            .foregroundColor(.green)
                    }
                }
                .frame(maxWidth: .infinity) // Equal width for both VStacks
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Mines")
                        .font(.headline)
                        .foregroundColor(.blue)
                    Picker("",selection: $pickedNumber) {
                        ForEach(1..<16) { number in
                            Text("\(number)")
                                .tag(number)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .labelsHidden()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1) // Border color and width
                    )
                 
                }
                .frame(maxWidth: .infinity) // Equal width for both VStacks
            }
            .frame(height: 100)
            .padding(.horizontal)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            
            Button("Start game") {
                cards = createList(bombNo: pickedNumber)
                disableUserInteraction = false
                disableGameSetting = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding() // Add padding to the whole VStack
        .background(Color.gray.opacity(0.1)) // Set background color
        .cornerRadius(15) // Add corner radius
        .allowsHitTesting(!disableGameSetting)
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
                GameSettingView(pickedNumber: Binding.constant(4), cards: cards, disableUserInteraction: .constant(false), disableGameSetting: .constant(false))
            }
        }
}
