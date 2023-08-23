/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 17/08/2023
 Last modified: 23/08/2023
 Acknowledgement:
 */

import Foundation

var achievements = decodeAchievement(jsonFileName: "achievement.json")

    
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

func saveToFile(userDatas: [String: UserData]) {
    let encoder = JSONEncoder()
    if let encodedData = try? encoder.encode(userDatas) {
        let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/userDatas.json"
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            try encodedData.write(to: fileURL)
            print("UserDatas saved to file: \(fileURL)")
        } catch {
            print("Error saving UserDatas: \(error)")
        }
    }
}

func appendToFile(newUserData: UserData) {
    // Load existing data if it exists, or create an empty dictionary
    var existingUserDatas = loadFromFile()
    
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
            print("New UserData added and saved to file: \(fileURL)")
        } catch {
            print("Error adding new UserData: \(error)")
        }
    }
}


func loadSingleFromFile(forUsername username: String) -> UserData? {
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
    } catch {
        print("Error loading UserData for username \(username): \(error)")
    }
    return nil
}

func loadFromFile() -> [String: UserData] {
    let filePath = "/Users/s3915177/Documents/GitHub/assignment2/assignment2/Utilities/userDatas.json"
    let fileURL = URL(fileURLWithPath: filePath)
    
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let userDatas = try decoder.decode([String: UserData].self, from: data)
        return userDatas
    } catch {
        print("Error loading UserDatas: \(error)")
    }
    return [:]
}
