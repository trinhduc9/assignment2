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
 */

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var userData: UserData
    @AppStorage("DarkMode") private var isDark: Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                isDark.toggle()
            }) {
                Image(systemName: isDark ? "moon.fill" : "sun.max")
                    .foregroundColor(isDark ? .white : .black)
            }
            Spacer()
            Button(action: {
                soundEnable.toggle()
            }) {
                Image(systemName: soundEnable ? "speaker.wave.3.fill" : "speaker.slash.fill")
                    .foregroundColor(isDark ? .white : .black)
            }
            Spacer()
            Button(action: {
                if !disableUserInteraction{
                    
                }
            }) {
                Text("Exit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
