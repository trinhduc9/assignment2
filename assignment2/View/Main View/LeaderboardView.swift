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

struct LeaderboardView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var selectedUsername: String? = nil
    
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
            Spacer()
            if selectedUsername != nil {
                Spacer()
                Button(action:{
                    selectedUsername = nil
                }){
                    Image(systemName: "arrowshape.backward.fill")
                }
            }
            List(filteredHighscores.prefix(10)) { highscore in
                HStack{
                    Text("\(highscore.name)")
                        .font(.headline)
                        .foregroundColor(.red)
                        .underline()
                        .onTapGesture {
                            selectedUsername = highscore.name
                        }
                    Spacer()
                    Text("$\(String(format: "%.2f", highscore.winning))")
                        .foregroundColor(.black)
                }.listRowBackground(Color("lightgray"))
            }.scrollContentBackground(.hidden)
        }
        .background(Color("backgroundcolor"))
            
    }
    
    // Function to filter highscores for a specific username
    var filteredHighscores: [Highscore] {
        if selectedUsername != nil {
            return highscores.filter { $0.name == selectedUsername }
        }else{
            return highscores
        }
        
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
