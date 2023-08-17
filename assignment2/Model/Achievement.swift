/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified:16/08/2023
 Acknowledgement:
 */

import Foundation
import SwiftUI

class Achievement: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var badge: String
    var badgeImage: Image {
        Image(badge)
    }
}
