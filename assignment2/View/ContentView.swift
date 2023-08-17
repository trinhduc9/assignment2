/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified:
 Acknowledgement:
 - https://www.youtube.com/watch?v=aJ9kKX6Ak3k
 */


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var isWelcomeActive: Bool = true
    
    var body: some View {
        ZStack {
            if isWelcomeActive { //Default welcome view
                WelcomeView(isWelcomeActive: $isWelcomeActive)
            } else {
                TabDisplayView()
                    .environmentObject(UserData.shared)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
