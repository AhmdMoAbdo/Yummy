//
//  MealDetailsInstructionsView.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import SwiftUI

struct InstructionsSection: View {
    // MARK: - Properties
    var instructions: [String]
    
    // MARK: - Drawing View
    var body: some View{
        VStack(alignment: .leading, spacing: 12) {
            MealDetailsSectionHeader(
                title: Constants.MealDetails.instructions,
                imageName: Constants.Images.mealDetailsInstuctionsSectionIcon
            )
            makeInstructionsList()
        }
        .padding(.bottom, (Shortcuts.window?.safeAreaInsets.bottom ?? 0) + 8)
    }
    
    // MARK: - Instructions List
    private func makeInstructionsList() -> some View {
        VStack(spacing: 16) {
            ForEach(instructions, id: \.self) { instruction in
                makeInstructionsCell(instruction)
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Instructions cell
    private func makeInstructionsCell(_ instruction: String) -> some View {
        Text(instruction)
            .font(.system(size: 16, weight: .medium))
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding(.all, 16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
    }
}
