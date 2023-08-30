/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 17/08/2023
 Last modified:
 Acknowledgement:
 */

import SwiftUI

struct StatsView: View {

    @EnvironmentObject var userData: UserData
    @AppStorage("Language") var lang: String = "en"
    var body: some View {
        
        VStack(alignment: .leading){
            Section(header:
                Text("User Stats")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
            ){
                HStack {
                    Text("Username:")
                        .font(.headline)
                    Text(userData.username)
                        .font(.body)
                }
                HStack {
                    Text("Balance:")
                        .font(.headline)
                    Text("$\(String(format: "%.2f", userData.balance))")
                        .font(.body)
                }
                HStack {
                    Text("Games Played:")
                        .font(.headline)
                    Text("\(userData.gamePlayed)")
                        .font(.body)
                }
                HStack {
                    Text("Total Bet:")
                        .font(.headline)
                    Text("$\(String(format: "%.2f", userData.totalBet))")
                        .font(.body)
                }
                HStack {
                    Text("Total Winning:")
                        .font(.headline)
                    Text("$\(String(format: "%.2f", userData.totalWinning))")
                        .font(.body)
                }
                HStack {
                    Text("Profit/Loss:")
                        .font(.headline)
                    Text("$\(String(format: "%.2f", userData.profitLoss))")
                        .font(.body)
                }
            }
            .padding(.leading)
            AchievementView()
                .environment(\.locale, .init(identifier: lang))
        }.background(Color("backgroundcolor"))
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(UserData.shared)
    }
}
