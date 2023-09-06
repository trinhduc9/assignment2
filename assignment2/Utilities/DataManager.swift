/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 17/08/2023
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

import Foundation

var achievements: [Achievement] = decodeAchievement(jsonFileName: "achievement.json") //Load achievement
var highscores: [Highscore] = loadHighscores() //Load highscore for leaderboard
    
//Decode achievement JSON
func decodeAchievement(jsonFileName: String) -> [Achievement] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Achievement].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Achievement]
}



//add user to json file
func appendToFile(newUserData: UserData) {
    var existingUserDatas = loadUserData()
    
    // Add the new user data using the username as the key
    existingUserDatas[newUserData.username] = newUserData
    
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(existingUserDatas) {
        let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/userDatas.json"
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            // Create the file if it doesn't exist
            if !FileManager.default.fileExists(atPath: filePath) {
                FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
            }
            try encodedData.write(to: fileURL)
        } catch {}
    }
}

//Load specific userdata by username
func loadSingleUserData(forUsername username: String) -> UserData? {
    let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/userDatas.json"
    let fileURL = URL(fileURLWithPath: filePath)
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let userDatas = try decoder.decode([String: UserData].self, from: data)
        
        if let userData = userDatas[username] {
            return userData
        } else {
            return nil
        }
    } catch {}
    return nil
}

//Load all userdata
func loadUserData() -> [String: UserData] {
    let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/userDatas.json"
    let fileURL = URL(fileURLWithPath: filePath)
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let userDatas = try decoder.decode([String: UserData].self, from: data)
        return userDatas
    } catch {}
    return [:]
}

//Create/append highscores.json
func appendHighscoreJSON(newHighscore: Highscore) {
    // Load existing highscores if they exist, or create an empty array
    var existingHighscores = loadHighscores()
    
    // Add the new highscore to the array
    existingHighscores.append(newHighscore)
    existingHighscores.sort { $0.winning > $1.winning }
    
    // Limit the highscores to the top 10
    if existingHighscores.count > 10 {
        existingHighscores.removeLast()
    }
    
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(existingHighscores) {
        let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/highscores.json"
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            // Create the file if it doesn't exist
            if !FileManager.default.fileExists(atPath: filePath) {
                FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
            }
            try encodedData.write(to: fileURL)
        } catch {}
    }
}

//Load highscore file
func loadHighscores() -> [Highscore] {
    let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/highscores.json"
    let fileURL = URL(fileURLWithPath: filePath)
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let highscores = try decoder.decode([Highscore].self, from: data)
        return highscores
    } catch {
        return []
    }
}
