//
//  Extension.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 29/08/2023.
//

import Foundation

extension Double {
    func rounded(to decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return (self * divisor).rounded(.toNearestOrEven) / divisor
    }
}
