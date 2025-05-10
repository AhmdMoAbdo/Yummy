//
//  ListCellDeleteSwipeAction.swift
//  Yummy
//
//  Created by Ahmed Abdo on 28/04/2025.
//

import SwiftUI

// MARK: - Adding swipe to delete action in list cell
extension View {
    func addListCellDeleteSwipeAction(action: @escaping () -> Void) -> some View {
        modifier(ListCellDeleteSwipeAction(action: action))
    }
}

struct ListCellDeleteSwipeAction: ViewModifier {
    // MARK: - Properties
    var action: () -> Void
    
    // MARK: - Drawing View
    func body(content: Content) -> some View {
        content
            .swipeActions{
                Button {
                    withAnimation {
                        action()
                    }
                } label: {
                    Label(Constants.MealCell.delete, systemImage: Constants.Images.mealCellDeleteIcon)
                }
                .tint(Color.red)
            }
    }
}
