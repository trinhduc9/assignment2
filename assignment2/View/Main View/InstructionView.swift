/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 29/08/2023
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

struct InstructionView: View {
    
    let images = ["instruction1", "instruction2", "instruction3"]
    let imageLabels = ["Select number of mines, input amount of money to bet and start game", "Tap on the card to flip\nMore diamond more money", "Avoid the bomb"]
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .center){
                Text("Instructions")
                    .font(.system(size: 30, weight: .bold))
                TabView{
                    ForEach(0..<3){ i in
                        VStack{
                            HStack(alignment: .firstTextBaseline){
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.red)
                                Text(LocalizedStringKey(imageLabels[i])) // Display the corresponding label
                                    .font(.system(size: 10, weight: .bold))
                                    .padding(.top, 8)
                                    .foregroundColor(.black)
                            }
                            Image("\(images[i])").resizable()
                                
                        }.background(.white)
                            .cornerRadius(10)
                    }
                }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
                .frame(width: (geo.size.width/5)*4, height: geo.size.height/5*4)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hue: 0.129, saturation: 0.98, brightness: 0.978), lineWidth: 2)
                    )
            }
            
            .position(x: geo.size.width / 2, y: geo.size.height / 2) // Centered position
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundcolor"))

    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
