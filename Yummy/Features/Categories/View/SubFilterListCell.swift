//
//  SubFilterListCell.swift
//  Yummy
//
//  Created by Ahmed Abdo on 06/05/2025.
//

import SwiftUI
import Kingfisher

// MARK: - Cell Model
struct CategoriesSubFilterCellModel: Codable {
    var title: String
    var imageName: String
}

struct SubFilterListCell: View {
    // MARK: - Propertie(s)
    var itemToDisplay: CategoriesSubFilterCellModel
    var isSelected: Bool
    var didSelectItem: () -> Void
    
    // MARK: - Drawing View
    var body: some View {
        ZStack(alignment: .bottom) {
            makeItemImage()
            makeOverlayItemName()
        }
        .frame(width: 130)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: isSelected ? 0 : 5)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.orange, lineWidth: isSelected ? 4.5 : 0)
        )
        .padding(.vertical, 8)
        .padding(.leading, 12)
        .onTapGesture {
            withAnimation {
                didSelectItem()
            }
        }
    }
    
    // MARK: - Cell Image
    private func makeItemImage() -> some View {
        KFImage(URL(string: itemToDisplay.imageName))
            .resizable()
            .scaledToFill()
            .frame(width: 160, height: 100)
    }
    
    // MARK: - Item Name
    private func makeOverlayItemName() -> some View {
        HStack {
            Spacer()
            
            Text(itemToDisplay.title)
                .padding(4)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold))
            
            Spacer()
        }
        .background(Color.black.opacity(0.5))
    }
}
