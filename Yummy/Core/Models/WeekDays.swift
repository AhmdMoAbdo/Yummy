//
//  WeekDays.swift
//  Yummy
//
//  Created by Ahmed on 28/08/2023.
//

import Foundation

enum WeekDays: String, CaseIterable{
    case sat = "Sat"
    case sun = "Sun"
    case mon = "Mon"
    case tue = "Tue"
    case wed = "Wed"
    case thu = "Thu"
    case fri = "Fri"
    
    func getFullDayName() -> String {
        switch self {
        case .sat:
            return "Saturday"
        case .sun:
            return "Sunday"
        case .mon:
            return "Monday"
        case .tue:
            return "Tuesday"
        case .wed:
            return "Wednesday"
        case .thu:
            return "Thursday"
        case .fri:
            return "Friday"
        }
    }
    
    func getFetchingCondition(for meal: Meal) -> Bool {
        switch self {
        case .sat:
            return meal.sat == true
            
        case .sun:
            return meal.sun == true
            
        case .mon:
            return meal.mon == true
            
        case .tue:
            return meal.tue == true
            
        case .wed:
            return meal.wed == true
            
        case .thu:
            return meal.thu == true
            
        case .fri:
            return meal.fri == true
        }
    }
    
    func getFetchingPredicate() -> Predicate<Meal> {
        switch self {
        case .sat:
            return #Predicate { $0.sat == true }
            
        case .sun:
            return #Predicate { $0.sun == true }
            
        case .mon:
            return #Predicate { $0.mon == true }
            
        case .tue:
            return #Predicate { $0.tue == true }
            
        case .wed:
            return #Predicate { $0.wed == true }
            
        case .thu:
            return #Predicate { $0.thu == true }
            
        case .fri:
            return #Predicate { $0.fri == true }
        }
    }
}
