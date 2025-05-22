//
//  EmptyStateView.swift
//  Yummy
//
//  Created by Ahmed Abdo on 28/04/2025.
//

import SwiftUI

struct EmptyStateView: View {
    // MARK: - Properties
    var imageName: String
    var message: String
    var opacity: Double = 0.6
    
    // MARK: - Drawing View
    var body: some View{
        VStack{
            Spacer()
            
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
            
            Text(message)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .opacity(opacity)
        .frame(width: 150)
    }
}

// MARK: - Preview
#Preview {
    EmptyStateView(imageName: "emptyCalendar", message: "No meals planned for today")
}
