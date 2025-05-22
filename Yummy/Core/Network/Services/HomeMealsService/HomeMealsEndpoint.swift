//
//  HomeMealsEndpoint.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

enum HomeMealsEndpoint: EndPoint {
    case homeMeal
}

extension HomeMealsEndpoint {
    var path: String {
        return "random.php"
    }
    
    var queryParameters: [String : String?] { [:] }
    
    var headers: [String : String] { [:] }
    
    var bodyParmaters: [String : Any?] { [:] }
}
