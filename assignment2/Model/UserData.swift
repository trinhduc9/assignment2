/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 25/08/2023
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

//Struct for UserData
class UserData: ObservableObject, Codable {
    static let shared = UserData()
    
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "Username")
        }
    }
    
    @Published var gamePlayed: Int {
        didSet {
            UserDefaults.standard.set(gamePlayed, forKey: "GamePlayed")
        }
    }
    
    @Published var balance: Double {
        didSet {
            UserDefaults.standard.set(balance, forKey: "Balance")
        }
    }
    
    @Published var totalBet: Double {
        didSet {
            UserDefaults.standard.set(totalBet, forKey: "TotalBet")
        }
    }
    
    @Published var totalWinning: Double {
        didSet {
            UserDefaults.standard.set(totalWinning, forKey: "TotalWinning")
        }
    }
    
    @Published var profitLoss: Double {
        didSet {
            UserDefaults.standard.set(profitLoss, forKey: "ProfitLoss")
        }
    }
    
    @Published var achievements: [Bool] {
        didSet {
            UserDefaults.standard.set(achievements, forKey: "Achievements")
        }
    }
    
    @Published var currentGame: [Card] {
        didSet {
            saveCurrentGame(game: currentGame)
        }
    }
    
    // CodingKeys enum and required init
    enum CodingKeys: String, CodingKey {
        case username
        case gamePlayed
        case balance
        case totalBet
        case totalWinning
        case profitLoss
        case achievements
        case currentGame
    }
    
    // Decoding initializer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.gamePlayed = try container.decode(Int.self, forKey: .gamePlayed)
        self.balance = try container.decode(Double.self, forKey: .balance)
        self.totalBet = try container.decode(Double.self, forKey: .totalBet)
        self.totalWinning = try container.decode(Double.self, forKey: .totalWinning)
        self.profitLoss = try container.decode(Double.self, forKey: .profitLoss)
        self.achievements = try container.decode([Bool].self, forKey: .achievements)
        self.currentGame = try container.decode([Card].self, forKey: .currentGame)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(gamePlayed, forKey: .gamePlayed)
        try container.encode(balance, forKey: .balance)
        try container.encode(totalBet, forKey: .totalBet)
        try container.encode(totalWinning, forKey: .totalWinning)
        try container.encode(profitLoss, forKey: .profitLoss)
        try container.encode(achievements, forKey: .achievements)
        try container.encode(currentGame, forKey: .currentGame)
    }
    
    //Initializer
    init() {
        self.username = UserDefaults.standard.string(forKey: "Username") ?? ""
        self.gamePlayed = UserDefaults.standard.integer(forKey: "GamePlayed")
        self.balance = UserDefaults.standard.double(forKey: "Balance")
        let storedUsername = UserDefaults.standard.string(forKey: "Username") ?? ""
        if storedUsername.isEmpty {
            self.balance = 100000.00
        } else {
            self.balance = UserDefaults.standard.double(forKey: "Balance")
        }
        self.totalBet = UserDefaults.standard.double(forKey: "TotalBet")
        self.totalWinning = UserDefaults.standard.double(forKey: "TotalWinning")
        self.profitLoss = UserDefaults.standard.double(forKey: "ProfitLoss")
        self.achievements = UserDefaults.standard.array(forKey: "Achievements") as? [Bool] ?? [false, false, false, false, false]
        if let savedCardsData = UserDefaults.standard.data(forKey: "CurrentGame"),
           let savedCards = try? JSONDecoder().decode([Card].self, from: savedCardsData) {
            self.currentGame = savedCards
        } else {
            self.currentGame = []
        }
    }
    
    //Update number of game played
    func updategamePlayed(){
        self.gamePlayed += 1
        UserDefaults.standard.set(self.gamePlayed, forKey: "GamePlayed")
    }
    
    //Update userbalance
    func updateBalance(balance: Double){
        let formatted = String(format: "%.2f", balance)
        self.balance += Double(formatted)!
        UserDefaults.standard.set(self.balance, forKey: "Balance")
    }

    //Update user total bet
    func updateTotalBet(bet: Double){
        let formatted = String(format: "%.2f", bet)
        self.totalBet += Double(formatted)!
        UserDefaults.standard.set(self.totalBet, forKey: "TotalBet")
    }

    //Update user profit and loss
    func updateProfitLoss(profitLoss: Double){
        let formatted = String(format: "%.2f", profitLoss)
        self.profitLoss += Double(formatted)!
        UserDefaults.standard.set(self.profitLoss, forKey: "ProfitLoss")
    }
    
    //update user total winning
    func updateTotalWinning(winning: Double){
        let formatted = String(format: "%.2f", winning)
        self.totalWinning += Double(formatted)!
        UserDefaults.standard.set(self.totalWinning, forKey: "TotalWinning")
    }

    //update user achievement                             
    func updateAchievement(index: Int){
        self.achievements[index] = true
        UserDefaults.standard.set(self.achievements, forKey: "Achievements")
    }
    
    //update the if card face up
    func updateCard(card: Card) {
        if let index = self.currentGame.firstIndex(where: { $0.id == card.id }) {
            currentGame[index] = card
            saveCurrentGame(game: currentGame)
        }
    }
    
    //Save the current game state
    func saveCurrentGame(game: [Card]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(game) {
            UserDefaults.standard.set(encoded, forKey: "CurrentGame")
        }
    }

    //Clear current user data
    func clearUserData() {
        // Set properties to their initial or reset values
        self.username = ""
        self.gamePlayed = 0
        self.balance = 100000.00 // Reset to default balance
        self.totalBet = 0.0
        self.totalWinning = 0.0
        self.profitLoss = 0.0
        self.achievements = [false, false, false, false, false]
        self.currentGame = []
    }
}

