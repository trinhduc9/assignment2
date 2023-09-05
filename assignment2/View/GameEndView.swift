//
//  GameEndView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 30/08/2023.
//

import SwiftUI

struct GameEndView: View {
    
    @AppStorage("Multiplier") var multiplier: Double = 1.0
    @AppStorage("CurrentBet") var inputText: String = ""
    @State private var isAppeared = false
    @Binding var isLoss: Bool
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
                    VStack {
                        Text("$\(String(format: "%.2f", multiplier))")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.green)
                        Rectangle()
                            .frame(height: 2) // Make the divider thicker
                            .foregroundColor(.black) // You can change the color as needed
                        
                        Text("$\(String(format: "%.2f", (Double(inputText)! * multiplier)))")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    .padding(10) // Add padding to the VStack
                    .background(Color("bluepurp")) // Set the background color of the VStack
                    .border(Color.black, width: 2) // Add a border to the VStack
                    .cornerRadius(8)
                    .frame(width: geo.size.width * 0.7, height: geo.size.width * 0.4) // Set the frame size of the VStack
                    .opacity(isAppeared ? 1 : 0) // Apply opacity based on appearance state
                    .scaleEffect(isAppeared ? 1 : 0.5)
                    .onAppear {
                        withAnimation(.easeIn(duration: 0.5)) { // Apply fade-in animation
                            isAppeared = true
                        }
                    }
                    .offset(x: (geo.size.width - (geo.size.width * 0.7)) / 2, y: (geo.size.height - (geo.size.width * 0.4)) / 2)

                    /*Image("appLogo")
                        .resizable()
                        .opacity(isAppeared ? 1 : 0) // Apply opacity based on appearance state
                        .scaleEffect(isAppeared ? 1 : 0.5)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.5)) { // Apply fade-in animation
                                isAppeared = true
                            }
                        }*/
            
                }
            }
        }
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView(isLoss: .constant(false))
    }
}
