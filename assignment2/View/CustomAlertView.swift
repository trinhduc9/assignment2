//
//  CustomAlertView.swift
//  assignment2
//
//  Created by Duc Trinh Van Minh on 28/08/2023.
//

import SwiftUI

struct CustomAlertView: View {
    var body: some View {
        @EnvironmentObject var alert: AlertModel
        
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    Text(title)
                        .font(.headline)
                        .padding()
                    
                    Text(message)
                        .font(.subheadline)
                        .padding()
                    
                    Button("OK") {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    .padding()
                }
                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
            .background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView()
    }
}
