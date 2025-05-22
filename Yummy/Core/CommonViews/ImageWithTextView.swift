//
//  ImageWithTextView.swift
//  Yummy
//
//  Created by Ahmed Abdo on 17/04/2025.
//

import SwiftUI

struct ImageWithTextView: View {
    // MARK: - Properties
    var title: String
    var imageName: String
    var textColor: Color = .white
    
    // MARK: - Drawing View
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20,height: 20)
                .scaledToFit()
                .foregroundColor(.orange)
            
            Text(title)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(textColor)
        }
    }
}
