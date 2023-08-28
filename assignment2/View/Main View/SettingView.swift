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
    @AppStorage("SoundEffectEnable") private var soundEffect: Bool = true
    @AppStorage("SoundEnable") private var soundEnable: Bool = true
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @Binding var lang: String
    
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
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                            .background(Color("lightgray"))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
                    }
                    Spacer()
                        .frame(width: geo.size.width/3)
                    
                    Button(action: {
                        soundEffect.toggle()
                    }){
                        Image(soundEffect ? "note" : "noteSlash")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .background(Color("lightgray"))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
                    }
                    Spacer()
                        .frame(width: geo.size.width/3)
                    Button(action: {
                        isDark.toggle()
                    }) {
                        Image(systemName: isDark ? "moon.fill" : "sun.max")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                            .background(Color("lightgray"))
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
                    }
                }
                Spacer()
                Group{
                    HStack{
                        Text("Languages:")
                        Picker("Select Language", selection: $lang) {
                            Text("English").tag("en")
                            Text("Español").tag("es")
                            Text("Vietnamese").tag("vi-VN")
                        }
                        .pickerStyle(MenuPickerStyle())
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
                        .frame(width: geo.size.width/4)
                        .padding()
                        .background(Color("lightblack"))
                        .foregroundColor(.white)
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
        @State(initialValue: "es") var lang: String
        SettingView(lang: $lang)
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
