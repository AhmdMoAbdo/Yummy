//
//  MealDetailsViewModel.swift
//  Yummy
//
//  Created by Ahmed on 22/08/2023.
//

import Foundation

class MealDetailsViewModel: ObservableObject{
    
    @Published var topIngredientsArr: [MealIngredient] = []
    @Published var bottomIngredientsArr: [MealIngredient] = []
    @Published var instructionsArr: [Substring] = []
    
    func prepareIngredientsArrays(meal: Meal){
        //Top Array
        meal.strIngredient1 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient1 ?? "", amount: meal.strMeasure1 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient1 ?? ""))) : ()
        meal.strIngredient3 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient3 ?? "", amount: meal.strMeasure3 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient3 ?? ""))) : ()
        meal.strIngredient5 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient5 ?? "", amount: meal.strMeasure5 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient5 ?? ""))) : ()
        meal.strIngredient7 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient7 ?? "", amount: meal.strMeasure7 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient7 ?? ""))) : ()
        meal.strIngredient9 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient9 ?? "", amount: meal.strMeasure9 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient9 ?? ""))) : ()
        meal.strIngredient11 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient11 ?? "", amount: meal.strMeasure11 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient11 ?? ""))) : ()
        meal.strIngredient13 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient13 ?? "", amount: meal.strMeasure13 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient13 ?? ""))) : ()
        meal.strIngredient15 ?? "" != "" ? topIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient15 ?? "", amount: meal.strMeasure15 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient15 ?? ""))) : ()
   
        //Bottom Array
        
        meal.strIngredient2 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient2 ?? "", amount: meal.strMeasure2 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient2 ?? ""))) : ()
        meal.strIngredient4 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient4 ?? "", amount: meal.strMeasure4 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient4 ?? ""))) : ()
        meal.strIngredient6 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient6 ?? "", amount: meal.strMeasure6 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient6 ?? ""))) : ()
        meal.strIngredient8 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient8 ?? "", amount: meal.strMeasure8 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient8 ?? ""))) : ()
        meal.strIngredient10 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient10 ?? "", amount: meal.strMeasure10 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient10 ?? ""))) : ()
        meal.strIngredient12 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient12 ?? "", amount: meal.strMeasure12 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient12 ?? ""))) : ()
        meal.strIngredient14 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient14 ?? "", amount: meal.strMeasure14 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient14 ?? ""))) : ()
        meal.strIngredient16 ?? "" != "" ? bottomIngredientsArr.append(MealIngredient(ingredientName: meal.strIngredient16 ?? "", amount: meal.strMeasure16 ?? "", thumbnail: getIngredientImage(ingredientName: meal.strIngredient16 ?? ""))) : ()
    }
    
    func prepareInstructions(meal: Meal){
        var instructions = meal.strInstructions ?? ""
        instructions = instructions.replacingOccurrences(of: "\r\n\r\n", with: "")
        instructions = instructions.replacingOccurrences(of: "\r\n", with: " ")
        instructions = instructions.replacingOccurrences(of: "\r", with: " ")
        instructions = instructions.replacingOccurrences(of: "\n", with: " ")
        instructions = instructions.replacingOccurrences(of: "  ", with: "")
        instructions = instructions.replacingOccurrences(of: "   ", with: "")
        instructions = instructions.replacingOccurrences(of: "    ", with: "")
        instructions = instructions.replacingOccurrences(of: "     ", with: "")
        while instructions.last == " "{
            instructions.removeLast()
        }
        var indiecesToRemove: [Int] = []
        var tempInstructionsArr = instructions.split(separator: ".")
        for (indx, instruction) in tempInstructionsArr.enumerated() {
            if instruction.isEmpty || instruction == " " || instruction.count < 5{
                indiecesToRemove.append(indx)
            }
        }
        var counter = 0
        for indx in indiecesToRemove{
            tempInstructionsArr.remove(at: indx - counter)
            counter += 1
        }
        instructionsArr = tempInstructionsArr
    }
    
    func getIngredientImage(ingredientName: String) -> String{
        let urlIngredientName = ingredientName.replacingOccurrences(of: " ", with: "%20")
        return "https://www.themealdb.com/images/ingredients/\(urlIngredientName).png"
    }
}
