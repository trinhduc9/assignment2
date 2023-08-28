//
//  CustomAlertView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 28/08/2023.
//

import SwiftUI

struct CustomAlertView: View {
    
    @Binding var isPresented: Bool
    let title: String
    let message: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(title)
                    .font(.headline)
                    .padding()
                
                Text(message)
                    .font(.subheadline)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height * 0.3) // Set the height
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.bottom) // Extend the view to the bottom
        }
        .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isPresented: .constant(true), title: "Custom Alert", message: "This is a preview of the custom alert.")
                    .background(Color.gray.opacity(0.2))
    }
}
