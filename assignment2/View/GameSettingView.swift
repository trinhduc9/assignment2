//
//  GameSettingView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 15/08/2023.
//

import SwiftUI

struct GameSettingView: View {
    @State private var pickedNumber: Int = 1
    @State private var inputText: String = ""
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Bet Ammount")){
                    ZStack(alignment: .trailing){
                        TextField("Ammount", text: $inputText)
                            .keyboardType(.numberPad)
                        Image(systemName: "dollarsign.circle")
                    }
                }
                Section(header: Text("Mines")){
                    List {
                        Picker("", selection: $pickedNumber) {
                            ForEach(1..<25) { number in
                                Text("\(number)")
                                    .tag(number)
                            }
                        }.pickerStyle(DefaultPickerStyle())
                    }
                }
            }
        }
    }
}

struct GameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GameSettingView()
    }
}
