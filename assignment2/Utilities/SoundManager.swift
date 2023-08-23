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
import AVFoundation

class AudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?

    func playSound(fileName: String, loops: Bool) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                if loops {
                    audioPlayer?.numberOfLoops = -1
                }
                audioPlayer?.play()
            } catch {
                print("Error: \(error)")
            }
        }
    }

    func stopSound() {
        audioPlayer?.stop()
    }
}