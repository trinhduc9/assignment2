//
//  Alert.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 28/08/2023.
//

import Foundation

class AlertModel: ObservableObject {
    @Published var isPresented = false
    var title = ""
    var message = ""
    
    func show(title: String, message: String) {
        self.title = title
        self.message = message
        isPresented = true
    }
    
    func dismiss() {
        isPresented = false
    }
}
