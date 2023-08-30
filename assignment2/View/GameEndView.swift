//
//  GameEndView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 30/08/2023.
//

import SwiftUI

struct GameEndView: View {
    
    @Binding var isLoss: Bool
    
    var body: some View {
        ZStack{
            if isLoss {
                ZStack{
                    Text("💣")
                        .font(.system(size: 250))
                    Text("YOU LOSS")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .fontWeight(.bold)
                }
            }else {
                Text("YOU WIN")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
            }
        }
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView(isLoss: .constant(true))
    }
}
