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
    var body: some View {
        
        VStack(alignment: .leading){
            Group{
                HStack{
                    Text("Username: ")
                    Text("\(userData.username)")
                }
                HStack{
                    Text("Balance:")
                    Text("$\(String(format: "%.2f", userData.balance))")
                }
                HStack{
                    Text("Game Played:")
                    Text("\(userData.gamePlayed)")
                }
                HStack{
                    Text("Total Bet:")
                    Text("$\(String(format: "%.2f", (userData.totalBet)))")
                }
                HStack{
                    Text("Total Winning:")
                    Text("$\(String(format: "%.2f", (userData.totalWinning)))")
                }
                HStack{
                    Text("Profit/Loss:")
                    Text("$\(String(format: "%.2f", (userData.profitLoss)))")
                }
            }.padding(.leading)
            AchievementView()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(UserData.shared)
    }
}
