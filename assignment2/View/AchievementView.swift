//
//  AchievementView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 21/08/2023.
//

import SwiftUI

struct AchievementView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        
        VStack {
            List {
                Section(header: Text("Unlocked Achievements")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top)){
                        ForEach(userData.achievements.indices, id: \.self) { index in
                            if userData.achievements[index] == true {
                                AchievementCardView(achievement: achievements[index])
                            }
                        }
                    }
                
                Section(header: Text("Locked Achievements")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top)){
                        ForEach(userData.achievements.indices, id: \.self) { index in
                            if userData.achievements[index] == false {
                                AchievementCardView(achievement: achievements[index])
                            }
                        }
                    }
            }
            .listStyle(GroupedListStyle())
            .scrollContentBackground(.hidden)
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        let audioManager = AudioManager()
        AchievementView()
            .environmentObject(UserData.shared)
            .environmentObject(audioManager)
    }
}
