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

func factorial(_ n: Int) -> Int {
    if n <= 1 {
        return 1
    } else {
        return n * factorial(n - 1)
    }
}

func nCr(n: Int, r: Int) -> Int {
    if r < 0 || r > n {
        return 0
    }
    return factorial(n) / (factorial(r) * factorial(n - r))
}

/*func nCr(n: Int, r: Int) -> Int {
    if r > n - r {
        return nCr(n: n, r: n - r)
    }
    var numerator = 1
    var denominator = 1
    for i in 1...r {
        numerator *= n + 1 - i
        denominator *= i
    }
    return numerator / denominator
}*/

func calculateMultiplier(mines: Int, diamonds: Int) -> Double {
    let houseEdge = 0.01
    return (1 - houseEdge) * Double(nCr(n: 16, r: diamonds)) / Double(nCr(n: 16 - mines,r: diamonds))
}
