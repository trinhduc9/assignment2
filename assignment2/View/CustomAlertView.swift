/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 28/08/2023
 Last modified: 28/08/2023
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

//Alert view
struct CustomAlertView: View {
    
    @AppStorage("Language") var lang: String = "en"
    @Binding var isPresented: Bool
    let title: String
    let message: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(LocalizedStringKey(title))
                    .font(.headline)
                    .padding()
                
                Text(LocalizedStringKey(message))
                    .font(.subheadline)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height * 0.3) // Set the height
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.bottom) // Extend the view to the bottom
        }
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isPresented: .constant(true), title: "Custom Alert", message: "This is a preview of the custom alert.")
                    .background(Color.gray.opacity(0.2))
    }
}
