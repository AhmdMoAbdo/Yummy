//
//  Shortcuts.swift
//  Yummy
//
//  Created by Ahmed Abdo on 06/05/2025.
//

import UIKit

enum Shortcuts {
    static var window: UIWindow? {
        (UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow })
    }
    
    static func getIngredientImage(ingredientName: String) -> String {
        let urlIngredientName = ingredientName.replacingOccurrences(of: " ", with: "%20")
        return "https://www.themealdb.com/images/ingredients/\(urlIngredientName).png"
    }
    
    static var tabbarHeight: CGFloat {
        return window?.safeAreaInsets.bottom ?? 0 > 0 ? 92 : 62
    }
}
