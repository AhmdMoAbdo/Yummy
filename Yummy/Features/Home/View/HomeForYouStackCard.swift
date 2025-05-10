//
//  HomeForYouStackCard.swift
//  Yummy
//
//  Created by Ahmed Abdo on 20/04/2025.
//

import SwiftUI

struct HomeForYouStackCard: View {
    // MARK: - Properties
    @State var offset: CGFloat = 0
    var index: Int
    var meal: Meal
    var swipeAction: () -> Void
    
    // MARK: - Drawing View
    var body: some View {
        MealCell(meal: meal, usageContext: .homeStack(index: index))
            .offset(x: offset, y: -(CGFloat(index <= 2 ? index : 2) * 15))
            .rotationEffect(.init(degrees: getRotaion(angle: 8)))
            .simultaneousGesture(
                DragGesture()
                    .onChanged({ value in
                        withAnimation {
                            offset = value.translation.width
                        }
                    })
                    .onEnded({ value in
                        handleEndDraggingAction(translation: value.translation.width)
                    })
            )
    }
    
    /// End Dragging action
    func handleEndDraggingAction(translation: CGFloat) {
        let width = UIScreen.main.bounds.width
        if abs(translation) > width - 16 {
            withAnimation {
                offset = .zero
                swipeAction()
            }
        } else if abs(translation) > width / 3 {
            withAnimation {
                offset = (translation > 0 ? width - 16 : -width + 16)
            } completion: {
                withAnimation {
                    offset = .zero
                    swipeAction()
                }
            }
        } else {
            withAnimation {
                offset = .zero
            }
        }
    }
    
    /// Get dragging rotation angle
    func getRotaion(angle: Double) -> Double {
        let rotation = (offset / (UIScreen.main.bounds.width - 50)) * angle
        return rotation
    }
}
