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
    
    var backgroundMusicPlayer: AVAudioPlayer?
    var soundEffectPlayer: AVAudioPlayer?

    func playBackgroundMusic(fileName: String, loops: Bool) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                if loops {
                    backgroundMusicPlayer?.numberOfLoops = -1
                }
                backgroundMusicPlayer?.play()
            } catch {
                print("Error: \(error)")
            }
        }
    }

    func playSoundEffect(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: "mp3") {
            do {
                soundEffectPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                soundEffectPlayer?.play()
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func stopSound() {
        backgroundMusicPlayer?.stop()
    }
}
