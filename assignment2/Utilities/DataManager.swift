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

class JSONManager {
    func decodeJsonFromJsonFile<T: Decodable>(jsonFileName: String, into type: T.Type) -> T? {
        if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil) {
            if let data = try? Data(contentsOf: file) {
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(type, from: data)
                    return decoded
                } catch let error {
                    print("Failed to decode JSON: \(error)")
                }
            }
        } else {
            print("Couldn't load \(jsonFileName) file")
        }
        
        return nil
    }

    func encodeJsonToFile<T: Encodable>(object: T, toFile jsonFileName: String) {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(object)
            if let jsonString = String(data: encoded, encoding: .utf8) {
                if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentsDirectory.appendingPathComponent(jsonFileName)
                    try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                    print("Encoded JSON saved to: \(fileURL)")
                }
            }
        } catch let error {
            print("Failed to encode JSON: \(error)")
        }
    }
}

