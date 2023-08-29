//
//  Extension.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 29/08/2023.
//

import Foundation
import SwiftUI

extension Double {
    func rounded(to decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return (self * divisor).rounded(.toNearestOrEven) / divisor
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
