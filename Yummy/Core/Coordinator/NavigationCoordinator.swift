//
//  NavigationCoordinator.swift
//  Yummy
//
//  Created by Ahmed Abdo on 05/05/2025.
//

import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func push(_ destination: Destination) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }

    func reset() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func getRelevantView(for destination: Destination) -> some View {
        switch destination {
        case let .mealDetails(meal):
            let viewModel = MealDetailsViewModel(meal: meal)
            MealDetails(viewModel: viewModel)
            
        case .search:
            Search()
        }
    }
}

enum Destination: Hashable {
    case mealDetails(meal: Meal)
    case search
}
