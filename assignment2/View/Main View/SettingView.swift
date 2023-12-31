/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 05/09/2023
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

struct SettingView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    @AppStorage("DarkMode") private var isDark: Bool = false
    @AppStorage("DisableUI") private var disableUserInteraction: Bool = true
    @AppStorage("GameEnded") private var gameEnded: Bool = false
    @AppStorage("IsLoss") private var isLoss: Bool = false
    @AppStorage("Language") var lang: String = "en"
    @State private var showAlert = false
    @Binding var soundEnable: Bool
    @Binding var soundEffect: Bool
    let availableLanguages: [String: String] = [
        "English": "en",
        "Español": "es",
        "Vietnamese": "vi_VN"
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
                        //Btn to toggle background music
                        Button(action: {
                            soundEnable.toggle()
                            UserDefaults.standard.set(soundEnable, forKey: "SoundEnableUD") //save value to userdefault
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
                        //Btn to toggle sound effect
                        Button(action: {
                            soundEffect.toggle()
                            UserDefaults.standard.set(soundEffect, forKey: "SoundEffectEnableUD") //save sound effect state to user default
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
                        //Btn to toggle theme setting
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
                        //Picker to select language
                        Picker("Select Language", selection: $lang) {
                            ForEach(availableLanguages.sorted(by: <), id: \.1) { key, value in
                                Text(LocalizedStringKey(key)).tag(value)
                            }
                        }
                        .accentColor(.black)
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                    //Exit button
                    Button(action: {
                        if disableUserInteraction{
                            userData.currentGame = []
                            appendToFile(newUserData: userData)
                            userData.clearUserData()
                            isLoss = false;
                            gameEnded = false;
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
                maxWidth: 300,
                maxHeight: 500
            )
            .border(isDark ? .white : .black, width: 2)
            .offset(x: (geo.size.width - 300) / 2, y: (geo.size.height - 500) / 2)
            .sheet(isPresented: $showAlert) {
                CustomAlertView(isPresented: $showAlert, title: "Error", message: "Can't exit, there's an ongoing game")
                    .environment(\.locale, .init(identifier: lang))
            }
        }.background(Color("backgroundcolor"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        @State(initialValue: "es") var lang: String
        SettingView(soundEnable: .constant(true), soundEffect: .constant(true))
            .environmentObject(AudioManager())
            .environment(\.locale, .init(identifier: lang))
    }
}
