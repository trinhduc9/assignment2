/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 30/08/2023
 Last modified: 30/08/2023
 Acknowledgement:
-   https://www.youtube.com/watch?v=VYxxzrlS8q0
-   https://www.youtube.com/watch?v=aJ9kKX6Ak3k
-	https://kowei-chen.medium.com/swiftui-dynamic-localization-tricks-87c37a6db3e7
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-provide-relative-sizes-using-geometryreader
-	https://stackoverflow.com/questions/62372188/how-to-use-userdata-observable-object-in-swiftui
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-disable-taps-for-a-view-using-allowshittesting
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-show-a-menu-when-a-button-is-pressed
-	https://developer.apple.com/documentation/swiftui/picker
-	https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid-using-lazyvgrid-and-lazyhgrid
 */

import SwiftUI

//End of game popup
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
                        Text("x\(String(format: "%.2f", multiplier))")
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
                    //Display the popup in the middle
                    .offset(x: (geo.size.width - (geo.size.width * 0.7)) / 2, y: (geo.size.height - (geo.size.width * 0.4)) / 2)
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
