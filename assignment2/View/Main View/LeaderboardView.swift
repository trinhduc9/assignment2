/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 29/08/2023
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

struct LeaderboardView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var selectedUsername: String? = nil
    
    var body: some View {
        VStack{
            Text("Leaderboard")
                .font(.largeTitle)
            Spacer()
            if selectedUsername != nil { //Display a return button if a user is selected to display their highscore
                Spacer()
                Button(action:{
                    selectedUsername = nil
                }){
                    Image(systemName: "arrowshape.backward.fill")
                }
            }
            //List of highscore
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
