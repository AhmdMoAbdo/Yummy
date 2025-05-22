//
//  TabbarItems.swift
//  Yummy
//
//  Created by Ahmed Abdo on 17/04/2025.
//

import Foundation

enum TabbarItems: Int, CaseIterable {
    case home = 0
    case categories
    case Favorite
    case WeekPlan
    
    /// Title
    var title: String{
        switch self {
        case .home:
            return Constants.Tabbar.tabbarHome
            
        case .categories:
            return Constants.Tabbar.tabbarCategories
            
        case .Favorite:
            return Constants.Tabbar.tabbarFavorite
            
        case .WeekPlan:
            return Constants.Tabbar.tabbarWeekPlan
        }
    }
    
    /// Image
    var iconName: String{
        switch self {
        case .home:
            return Constants.Images.tabbarHome
            
        case .categories:
            return Constants.Images.tabbarCategories
            
        case .Favorite:
            return Constants.Images.tabbarFavorite
            
        case .WeekPlan:
            return Constants.Images.tabbarWeekPlan
        }
    }
}
