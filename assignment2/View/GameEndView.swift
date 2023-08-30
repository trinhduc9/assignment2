//
//  GameEndView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 30/08/2023.
//

import SwiftUI

struct GameEndView: View {
    
    @Binding var isLoss: Bool
    @State private var isAppeared = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                if isLoss {
                    ZStack{
                        Image("explosion")
                            .resizable()
                            .opacity(isAppeared ? 1 : 0) // Apply opacity based on appearance state
                            .scaleEffect(isAppeared ? 1 : 0.5)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) { // Apply fade-in animation
                                    isAppeared = true
                                }
                            }
                    }
                }else {
                    VStack{
                        Image("applogo")
                            .resizable()
                            .opacity(isAppeared ? 1 : 0) // Apply opacity based on appearance state
                            .scaleEffect(isAppeared ? 1 : 0.5)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) { // Apply fade-in animation
                                    isAppeared = true
                                }
                            }
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
