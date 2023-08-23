/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 23/08/2023
 Acknowledgement:
- https://medium.com/@amitsrivastava115/toggle-between-dark-and-light-mode-in-swiftui-across-whole-app-5ccfc06a8eca
 */

import SwiftUI

@main
struct assignment2App: App {
    
    @StateObject private var userData = UserData()
    @StateObject private var audioManager = AudioManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData.shared)
                .environmentObject(audioManager)
        }
    }
}
