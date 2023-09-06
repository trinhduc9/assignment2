/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 17/08/2023
 Last modified: 28/08/2023
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
import AVFoundation

class AudioManager: ObservableObject {
    
    var backgroundMusicPlayer: AVAudioPlayer?
    var soundEffectPlayer: AVAudioPlayer?

    //Func to play background music
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

    //func to play sound effect
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
    
    //func to stop background music
    func stopSound() {
        backgroundMusicPlayer?.stop()
    }
}
