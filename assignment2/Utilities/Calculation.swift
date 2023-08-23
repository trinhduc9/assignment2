/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Trinh Van Minh Duc
 ID: s3915177
 Created  date: 23/08/2023
 Last modified:
 Acknowledgement:
 */
import Foundation

func nCr(_ n: Int, _ r: Int) -> Int {
    let f = { (num: Int) -> Int in
        return (1...num).reduce(1, *)
    }
    return f(n) / (f(r) * f(n - r))
}

func calculateMultiplier(mines: Int, diamonds: Int) -> Double {
    let houseEdge = 0.01
    return (1 - houseEdge) * Double(nCr(16, diamonds)) / Double(nCr(16 - mines, diamonds))
}