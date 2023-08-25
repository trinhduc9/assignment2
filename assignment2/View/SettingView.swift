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
 */

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("DarkMode") private var isDark: Bool = false
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    
    var body: some View {
        GeometryReader{geo in
            VStack(alignment: .center){
                Spacer()
                HStack{
                    Button(action: {
                        soundEnable.toggle()
                        if soundEnable{
                            audioManager.playSound(fileName: "backgroundMusic", loops: true)
                        }else{
                            audioManager.stopSound()
                        }
                    }) {
                        Image(systemName: soundEnable ? "speaker.wave.3.fill" : "speaker.slash.fill")
                            .foregroundColor(isDark ? .white : .black)
                    }
                    Spacer()
                        .frame(width: geo.size.width/2)
                    Button(action: {
                        isDark.toggle()
                    }) {
                        Image(systemName: isDark ? "moon.fill" : "sun.max")
                            .foregroundColor(isDark ? .white : .black)
                    }
                }
                Spacer()
                
                Button(action: {
                    if disableUserInteraction{
                        userData.currentGame = []
                        appendToFile(newUserData: userData)
                        userData.clearUserData()
                    }
                    
                }) {
                    Text("Exit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgroundcolor"))
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AudioManager())
    }
}
