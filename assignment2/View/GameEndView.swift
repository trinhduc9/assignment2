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
        GeometryReader{ geo in
            ZStack{
                if isLoss {
                    ZStack{
                        Image("explosion")
                            .resizable()
                        Text("YOU LOSS")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.top, 50)
                            .padding(.trailing)
                    }
                }else {
                    ZStack{
                        Text("YOU WIN")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView(isLoss: .constant(true))
    }
}
