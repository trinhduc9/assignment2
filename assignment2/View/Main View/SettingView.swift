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
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @State var soundEnable = UserDefaults.standard.bool(forKey: "SoundEnableUD")
    @State var soundEffect = UserDefaults.standard.bool(forKey: "SoundEffectEnableUD")
    @State private var showAlert = false
    @Binding var lang: String
    let availableLanguages: [String: String] = [
        "English": "en",
        "Español": "es",
        "Vietnamese": "vi-VN"
    ]
    
    var body: some View {
        GeometryReader{geo in
            VStack(alignment: .leading, spacing: 10){
                Spacer()
                Text("Settings")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Group{
                    HStack{
                        Text("Background music:")
                            .foregroundColor(.black)
                        Button(action: {
                            soundEnable.toggle()
                            UserDefaults.standard.set(soundEnable, forKey: "SoundEnableUD")
                            if soundEnable{
                                audioManager.playBackgroundMusic(fileName: "backgroundMusic", loops: true)
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
                    }
                    HStack{
                        Text("Sound effect:")
                            .foregroundColor(.black)
                        Button(action: {
                            soundEffect.toggle()
                            UserDefaults.standard.set(soundEffect, forKey: "SoundEffectEnableUD")
                        }){
                            Image(soundEffect ? "note" : "noteSlash")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .background(Color("lightgray"))
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 2)
                        }
                    }
                    HStack{
                        Text("Theme setting:")
                            .foregroundColor(.black)
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
                }
                Spacer()
                Group{
                    HStack{
                        Text("Languages:")
                            .foregroundColor(.black)
                        Picker("Select Language", selection: $lang) {
                            ForEach(availableLanguages.sorted(by: <), id: \.1) { key, value in
                                Text(key).tag(value)
                            }
                        }
                        .accentColor(.black)
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        if disableUserInteraction{
                            userData.currentGame = []
                            appendToFile(newUserData: userData)
                            userData.clearUserData()
                        }
                        else{
                            showAlert.toggle()
                        }
                    }) {
                        Text("Exit")
                            .frame(width: geo.size.width/6)
                            .padding()
                            .background(Color("lightblack"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal)
            .background(Color("lightgray"))
            .frame(
                maxWidth: geo.size.width * 0.7,
                maxHeight: geo.size.height * 0.7
            )
            .border(isDark ? .white : .black, width: 2)
            .offset(x: (geo.size.width - geo.size.width * 0.7) / 2, y: (geo.size.height - geo.size.height * 0.7) / 2)
            .sheet(isPresented: $showAlert) {
                CustomAlertView(isPresented: $showAlert, title: "Exit Alert", message: "Can't exit, there's an onging game")
            }
        }.background(Color("backgroundcolor"))
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
