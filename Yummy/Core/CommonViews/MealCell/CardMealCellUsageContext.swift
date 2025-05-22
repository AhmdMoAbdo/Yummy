//
//  CardMealCellUsageContext.swift
//  Yummy
//
//  Created by Ahmed Abdo on 27/04/2025.
//

import Foundation

enum CardMealCellUsageContext {
    case homeStack(index: Int)
    case normalCell
    
    func getCellHeight() -> CGFloat {
        switch self {
        case .homeStack:
            return 230
            
        case .normalCell:
            return 180
        }
    }
    
    func getHomeCellIndex() -> Int? {
        switch self {
        case let .homeStack(index):
            return index
            
        case .normalCell:
            return nil
        }
    }
    
    func shouldShowFavButton() -> Bool {
        switch self {
        case .homeStack:
            return false
            
        case .normalCell:
            return true
        }
    }
    
    func shadowRadius() -> CGFloat {
        switch self {
        case .homeStack:
            return 0
            
        case .normalCell:
            return 5
        }
    }
}
