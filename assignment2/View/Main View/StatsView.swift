/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 17/08/2023
 Last modified: 27/08/2023
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

struct StatsView: View {

    @EnvironmentObject var userData: UserData
    @AppStorage("Language") var lang: String = "en"
    var body: some View {
        
        VStack(alignment: .leading){
            //User stats section
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
            //Display user achievement
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
