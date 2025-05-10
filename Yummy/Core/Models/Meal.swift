//
//  Meal.swift
//  Yummy
//
//  Created by Ahmed on 21/08/2023.
//

import Foundation
import SwiftData

@Model
final class Meal {
    @Attribute(.unique) var idMeal: String?
    var strMeal: String?
    var strCategory: String?
    var strArea: String?
    var strInstructions: String?
    var strMealThumb: String?
    var strTags: String?
    var strYoutube: String?
    var strIngredient1: String?
    var strIngredient2: String?
    var strIngredient3: String?
    var strIngredient4: String?
    var strIngredient5: String?
    var strIngredient6: String?
    var strIngredient7: String?
    var strIngredient8: String?
    var strIngredient9: String?
    var strIngredient10: String?
    var strIngredient11: String?
    var strIngredient12: String?
    var strIngredient13: String?
    var strIngredient14: String?
    var strIngredient15: String?
    var strIngredient16: String?
    var strIngredient17: String?
    var strIngredient18: String?
    var strIngredient19: String?
    var strIngredient20: String?
    var strMeasure1: String?
    var strMeasure2: String?
    var strMeasure3: String?
    var strMeasure4: String?
    var strMeasure5: String?
    var strMeasure6: String?
    var strMeasure7: String?
    var strMeasure8: String?
    var strMeasure9: String?
    var strMeasure10: String?
    var strMeasure11: String?
    var strMeasure12: String?
    var strMeasure13: String?
    var strMeasure14: String?
    var strMeasure15: String?
    var strMeasure16: String?
    var strMeasure17: String?
    var strMeasure18: String?
    var strMeasure19: String?
    var strMeasure20: String?
    var fav: Bool?
    var sat: Bool?
    var sun: Bool?
    var mon: Bool?
    var tue: Bool?
    var wed: Bool?
    var thu: Bool?
    var fri: Bool?
    
    init() {}
    
    // MARK: - Ingrident lists to be used in meal details
    var ingredientsArr: [MealIngredient] {
        var ingredientsArray = [MealIngredient]()
        addIngrident(ingridentName: strIngredient1, measure: strMeasure1, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient2, measure: strMeasure2, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient3, measure: strMeasure3, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient4, measure: strMeasure4, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient5, measure: strMeasure5, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient6, measure: strMeasure6, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient7, measure: strMeasure7, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient8, measure: strMeasure8, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient9, measure: strMeasure9, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient10, measure: strMeasure10, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient11, measure: strMeasure11, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient12, measure: strMeasure12, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient13, measure: strMeasure13, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient14, measure: strMeasure14, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient15, measure: strMeasure15, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient16, measure: strMeasure16, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient17, measure: strMeasure17, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient18, measure: strMeasure18, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient19, measure: strMeasure19, to: &ingredientsArray)
        addIngrident(ingridentName: strIngredient20, measure: strMeasure20, to: &ingredientsArray)
        return ingredientsArray
    }
    
    /// Adding a specific ingredient to the ingridents array
    func addIngrident(
        ingridentName: String?,
        measure: String?,
        to array: inout [MealIngredient]
    ) {
        guard let ingridentName, let measure, !ingridentName.isEmpty else { return }
        let ingrident = MealIngredient(
            ingredientName: ingridentName,
            amount: measure,
            thumbnail: Shortcuts.getIngredientImage(ingredientName: ingridentName)
        )
        array.append(ingrident)
    }
    
    // MARK: - Instructions array to be used in meal details
    var instructions: [String] {
        let instructions = (strInstructions ?? "")
            .replacingOccurrences(of: "\r\n\r\n", with: "")
            .replacingOccurrences(of: "\r\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\t", with: "")
        var tempInstructionsArr = instructions.split(separator: ".")
        tempInstructionsArr.removeAll { $0.isEmpty || $0 == " " || $0.count < 5 }
        let cleanArr = tempInstructionsArr.map {
            var stringToBeManipulated = (String($0))
            while stringToBeManipulated.last == " " {
                stringToBeManipulated.removeLast()
            }
            while stringToBeManipulated.first == " " {
                stringToBeManipulated.removeFirst()
            }
            return stringToBeManipulated
        }
        print(cleanArr)
        return cleanArr
    }
}

extension Meal: Codable {
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
        case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
        case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        case fav, sat, sun, mon, tue, wed, thu, fri
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idMeal = try container.decodeIfPresent(String.self, forKey: .idMeal)
        strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        strIngredient1 = try container.decodeIfPresent(String.self, forKey: .strIngredient1)
        strIngredient2 = try container.decodeIfPresent(String.self, forKey: .strIngredient2)
        strIngredient3 = try container.decodeIfPresent(String.self, forKey: .strIngredient3)
        strIngredient4 = try container.decodeIfPresent(String.self, forKey: .strIngredient4)
        strIngredient5 = try container.decodeIfPresent(String.self, forKey: .strIngredient5)
        strIngredient6 = try container.decodeIfPresent(String.self, forKey: .strIngredient6)
        strIngredient7 = try container.decodeIfPresent(String.self, forKey: .strIngredient7)
        strIngredient8 = try container.decodeIfPresent(String.self, forKey: .strIngredient8)
        strIngredient9 = try container.decodeIfPresent(String.self, forKey: .strIngredient9)
        strIngredient10 = try container.decodeIfPresent(String.self, forKey: .strIngredient10)
        strIngredient11 = try container.decodeIfPresent(String.self, forKey: .strIngredient11)
        strIngredient12 = try container.decodeIfPresent(String.self, forKey: .strIngredient12)
        strIngredient13 = try container.decodeIfPresent(String.self, forKey: .strIngredient13)
        strIngredient14 = try container.decodeIfPresent(String.self, forKey: .strIngredient14)
        strIngredient15 = try container.decodeIfPresent(String.self, forKey: .strIngredient15)
        strIngredient16 = try container.decodeIfPresent(String.self, forKey: .strIngredient16)
        strIngredient17 = try container.decodeIfPresent(String.self, forKey: .strIngredient17)
        strIngredient18 = try container.decodeIfPresent(String.self, forKey: .strIngredient18)
        strIngredient19 = try container.decodeIfPresent(String.self, forKey: .strIngredient19)
        strIngredient20 = try container.decodeIfPresent(String.self, forKey: .strIngredient20)

        strMeasure1 = try container.decodeIfPresent(String.self, forKey: .strMeasure1)
        strMeasure2 = try container.decodeIfPresent(String.self, forKey: .strMeasure2)
        strMeasure3 = try container.decodeIfPresent(String.self, forKey: .strMeasure3)
        strMeasure4 = try container.decodeIfPresent(String.self, forKey: .strMeasure4)
        strMeasure5 = try container.decodeIfPresent(String.self, forKey: .strMeasure5)
        strMeasure6 = try container.decodeIfPresent(String.self, forKey: .strMeasure6)
        strMeasure7 = try container.decodeIfPresent(String.self, forKey: .strMeasure7)
        strMeasure8 = try container.decodeIfPresent(String.self, forKey: .strMeasure8)
        strMeasure9 = try container.decodeIfPresent(String.self, forKey: .strMeasure9)
        strMeasure10 = try container.decodeIfPresent(String.self, forKey: .strMeasure10)
        strMeasure11 = try container.decodeIfPresent(String.self, forKey: .strMeasure11)
        strMeasure12 = try container.decodeIfPresent(String.self, forKey: .strMeasure12)
        strMeasure13 = try container.decodeIfPresent(String.self, forKey: .strMeasure13)
        strMeasure14 = try container.decodeIfPresent(String.self, forKey: .strMeasure14)
        strMeasure15 = try container.decodeIfPresent(String.self, forKey: .strMeasure15)
        strMeasure16 = try container.decodeIfPresent(String.self, forKey: .strMeasure16)
        strMeasure17 = try container.decodeIfPresent(String.self, forKey: .strMeasure17)
        strMeasure18 = try container.decodeIfPresent(String.self, forKey: .strMeasure18)
        strMeasure19 = try container.decodeIfPresent(String.self, forKey: .strMeasure19)
        strMeasure20 = try container.decodeIfPresent(String.self, forKey: .strMeasure20)

        fav = try container.decodeIfPresent(Bool.self, forKey: .fav)
        sat = try container.decodeIfPresent(Bool.self, forKey: .sat)
        sun = try container.decodeIfPresent(Bool.self, forKey: .sun)
        mon = try container.decodeIfPresent(Bool.self, forKey: .mon)
        tue = try container.decodeIfPresent(Bool.self, forKey: .tue)
        wed = try container.decodeIfPresent(Bool.self, forKey: .wed)
        thu = try container.decodeIfPresent(Bool.self, forKey: .thu)
        fri = try container.decodeIfPresent(Bool.self, forKey: .fri)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(idMeal, forKey: .idMeal)
        try container.encodeIfPresent(strMeal, forKey: .strMeal)
        try container.encodeIfPresent(strCategory, forKey: .strCategory)
        try container.encodeIfPresent(strArea, forKey: .strArea)
        try container.encodeIfPresent(strInstructions, forKey: .strInstructions)
        try container.encodeIfPresent(strMealThumb, forKey: .strMealThumb)
        try container.encodeIfPresent(strTags, forKey: .strTags)
        try container.encodeIfPresent(strYoutube, forKey: .strYoutube)

        try container.encodeIfPresent(strIngredient1, forKey: .strIngredient1)
        try container.encodeIfPresent(strIngredient2, forKey: .strIngredient2)
        try container.encodeIfPresent(strIngredient3, forKey: .strIngredient3)
        try container.encodeIfPresent(strIngredient4, forKey: .strIngredient4)
        try container.encodeIfPresent(strIngredient5, forKey: .strIngredient5)
        try container.encodeIfPresent(strIngredient6, forKey: .strIngredient6)
        try container.encodeIfPresent(strIngredient7, forKey: .strIngredient7)
        try container.encodeIfPresent(strIngredient8, forKey: .strIngredient8)
        try container.encodeIfPresent(strIngredient9, forKey: .strIngredient9)
        try container.encodeIfPresent(strIngredient10, forKey: .strIngredient10)
        try container.encodeIfPresent(strIngredient11, forKey: .strIngredient11)
        try container.encodeIfPresent(strIngredient12, forKey: .strIngredient12)
        try container.encodeIfPresent(strIngredient13, forKey: .strIngredient13)
        try container.encodeIfPresent(strIngredient14, forKey: .strIngredient14)
        try container.encodeIfPresent(strIngredient15, forKey: .strIngredient15)
        try container.encodeIfPresent(strIngredient16, forKey: .strIngredient16)
        try container.encodeIfPresent(strIngredient17, forKey: .strIngredient17)
        try container.encodeIfPresent(strIngredient18, forKey: .strIngredient18)
        try container.encodeIfPresent(strIngredient19, forKey: .strIngredient19)
        try container.encodeIfPresent(strIngredient20, forKey: .strIngredient20)

        try container.encodeIfPresent(strMeasure1, forKey: .strMeasure1)
        try container.encodeIfPresent(strMeasure2, forKey: .strMeasure2)
        try container.encodeIfPresent(strMeasure3, forKey: .strMeasure3)
        try container.encodeIfPresent(strMeasure4, forKey: .strMeasure4)
        try container.encodeIfPresent(strMeasure5, forKey: .strMeasure5)
        try container.encodeIfPresent(strMeasure6, forKey: .strMeasure6)
        try container.encodeIfPresent(strMeasure7, forKey: .strMeasure7)
        try container.encodeIfPresent(strMeasure8, forKey: .strMeasure8)
        try container.encodeIfPresent(strMeasure9, forKey: .strMeasure9)
        try container.encodeIfPresent(strMeasure10, forKey: .strMeasure10)
        try container.encodeIfPresent(strMeasure11, forKey: .strMeasure11)
        try container.encodeIfPresent(strMeasure12, forKey: .strMeasure12)
        try container.encodeIfPresent(strMeasure13, forKey: .strMeasure13)
        try container.encodeIfPresent(strMeasure14, forKey: .strMeasure14)
        try container.encodeIfPresent(strMeasure15, forKey: .strMeasure15)
        try container.encodeIfPresent(strMeasure16, forKey: .strMeasure16)
        try container.encodeIfPresent(strMeasure17, forKey: .strMeasure17)
        try container.encodeIfPresent(strMeasure18, forKey: .strMeasure18)
        try container.encodeIfPresent(strMeasure19, forKey: .strMeasure19)
        try container.encodeIfPresent(strMeasure20, forKey: .strMeasure20)

        try container.encodeIfPresent(fav, forKey: .fav)
        try container.encodeIfPresent(sat, forKey: .sat)
        try container.encodeIfPresent(sun, forKey: .sun)
        try container.encodeIfPresent(mon, forKey: .mon)
        try container.encodeIfPresent(tue, forKey: .tue)
        try container.encodeIfPresent(wed, forKey: .wed)
        try container.encodeIfPresent(thu, forKey: .thu)
        try container.encodeIfPresent(fri, forKey: .fri)
    }
}

// MARK: - Initializer(s)
extension Meal {
    convenience init(
        idMeal: String? = nil,
        strMeal: String? = nil,
        strCategory: String? = nil,
        strArea: String? = nil,
        strInstructions: String? = nil,
        strMealThumb: String? = nil,
        strTags: String? = nil,
        strYoutube: String? = nil,
        strIngredient1: String? = nil,
        strIngredient2: String? = nil,
        strIngredient3: String? = nil,
        strIngredient4: String? = nil,
        strIngredient5: String? = nil,
        strIngredient6: String? = nil,
        strIngredient7: String? = nil,
        strIngredient8: String? = nil,
        strIngredient9: String? = nil,
        strIngredient10: String? = nil,
        strIngredient11: String? = nil,
        strIngredient12: String? = nil,
        strIngredient13: String? = nil,
        strIngredient14: String? = nil,
        strIngredient15: String? = nil,
        strIngredient16: String? = nil,
        strIngredient17: String? = nil,
        strIngredient18: String? = nil,
        strIngredient19: String? = nil,
        strIngredient20: String? = nil,
        strMeasure1: String? = nil,
        strMeasure2: String? = nil,
        strMeasure3: String? = nil,
        strMeasure4: String? = nil,
        strMeasure5: String? = nil,
        strMeasure6: String? = nil,
        strMeasure7: String? = nil,
        strMeasure8: String? = nil,
        strMeasure9: String? = nil,
        strMeasure10: String? = nil,
        strMeasure11: String? = nil,
        strMeasure12: String? = nil,
        strMeasure13: String? = nil,
        strMeasure14: String? = nil,
        strMeasure15: String? = nil,
        strMeasure16: String? = nil,
        strMeasure17: String? = nil,
        strMeasure18: String? = nil,
        strMeasure19: String? = nil,
        strMeasure20: String? = nil,
        fav: Bool? = nil,
        sat: Bool? = nil,
        sun: Bool? = nil,
        mon: Bool? = nil,
        tue: Bool? = nil,
        wed: Bool? = nil,
        thu: Bool? = nil,
        fri: Bool? = nil
    ) {
        self.init()
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strTags = strTags
        self.strYoutube = strYoutube
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20
        self.fav = fav
        self.sat = sat
        self.sun = sun
        self.mon = mon
        self.tue = tue
        self.wed = wed
        self.thu = thu
        self.fri = fri
    }
}
