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
    
    @ObservedObject var userData = UserData.shared
    @State private var selectedUsername: String? = nil
    
    var body: some View {
        NavigationView {
            VStack{
                if selectedUsername != nil {
                    Button(action:{
                        selectedUsername = nil
                    }){
                        Image(systemName: "arrowshape.backward.fill")
                    }
                }
                List(filteredHighscores) { highscore in
                    HStack{
                        Text("\(highscore.name)")
                            .font(.headline)
                            .foregroundColor(.black)
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
            .navigationBarTitle("Leaderboard")
            
        }
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
