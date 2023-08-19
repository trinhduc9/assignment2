/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified: 15/08/2023
 Acknowledgement:
 */

import SwiftUI

class UserData: ObservableObject {
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
    
    /*@Published var currentGame: [Card] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(currentGame) {
                UserDefaults.standard.set(encoded, forKey: "CurrentGame")
            }
        }
    }*/
    
    init() {
        self.username = UserDefaults.standard.string(forKey: "Username") ?? ""
        self.gamePlayed = UserDefaults.standard.integer(forKey: "GamePlayed")
        self.balance = UserDefaults.standard.double(forKey: "Balance")
        if UserDefaults.standard.object(forKey: "FirstLaunch") == nil {
            self.balance = 100000.00
            UserDefaults.standard.set(true, forKey: "FirstLaunch")
            UserDefaults.standard.set(100000.00, forKey: "Balance")
        }
        self.totalBet = UserDefaults.standard.double(forKey: "TotalBet")
        self.totalWinning = UserDefaults.standard.double(forKey: "TotalWinning")
        self.profitLoss = UserDefaults.standard.double(forKey: "ProfitLoss")
        self.achievements = UserDefaults.standard.array(forKey: "Achievements") as? [Bool] ?? [false, false, false, false, false]
        /*if let savedCardsData = UserDefaults.standard.data(forKey: "CurrentGame"),
           let savedCards = try? JSONDecoder().decode([Card].self, from: savedCardsData) {
            self.currentGame = savedCards
        } else {
            self.currentGame = []
        }*/
    }
}


