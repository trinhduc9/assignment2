//
//  Highscore.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 29/08/2023.
//

import Foundation

struct Highscore: Identifiable, Codable {
    let id = UUID()
    let name: String
    let winning: Double
    
}

func appendHighscoreLocal(name: String, winning: Double){
    let newHighscore = Highscore(name: name, winning: winning)
    highscores.append(newHighscore)
    highscores.sort { $0.winning > $1.winning }
    appendHighscoreJSON(newHighscore: newHighscore)
}

/*func appendHighscoreLocal(username: String, inputText: String, multiplier: Double) {
    if let inputValue = Double(inputText) {
        let roundedWinning = (inputValue * multiplier).rounded(to: 2)
        let newHighscore = Highscore(name: username, winning: roundedWinning)
        // Add the new highscore to your data storage and save it to file
    } else {
        // Handle invalid input
    }
}*/


