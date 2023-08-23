/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 11/08/2023
 Last modified:17/08/2023
 Acknowledgement:
 */

import Foundation
import SwiftUI

class Achievement: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var achieved: Bool
    var badge: String
}
