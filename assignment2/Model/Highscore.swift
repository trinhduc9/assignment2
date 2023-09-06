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




