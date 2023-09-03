//
//  RealmManger.swift
//  Yummy
//
//  Created by Ahmed on 27/08/2023.
//

import Foundation
import RealmSwift

class RealmManger{
    
    static var dbManger = RealmManger()
    private var db: Realm
    private init(){
        db = try! Realm()
    }
    
    func getFavouriteMeals() -> [Meal]{
        var mealsArrToReturn: [Meal] = []
        let savedMeals = db.objects(Meal.self).where{$0.fav == true}
        for meal in savedMeals{
            mealsArrToReturn.append(prepareNewMeal(meal: meal))
        }
        return mealsArrToReturn
    }
    
    func addMealToFav(meal: Meal){
        var foundMealsArr: [Meal] = []
        let savedMeals = db.objects(Meal.self).where{$0.strMeal == meal.strMeal}
        for meal in savedMeals{
            foundMealsArr.append(prepareNewMeal(meal: meal))
        }
        try! db.write({
            db.delete(savedMeals)
        })
        if foundMealsArr.isEmpty{
            let mealToBeAdded = meal
            mealToBeAdded.fav = true
            mealToBeAdded.sat = false
            mealToBeAdded.sun = false
            mealToBeAdded.mon = false
            mealToBeAdded.tue = false
            mealToBeAdded.wed = false
            mealToBeAdded.thu = false
            mealToBeAdded.fri = false
            try! db.write {
                db.create(Meal.self,value: mealToBeAdded)
            }
        }else{
            foundMealsArr[0].fav = true
            try! db.write {
                db.create(Meal.self,value: foundMealsArr[0])
            }
        }
    }
    
    func checkMealIsInFav(meal: Meal) -> Bool{
        let savedMeals = db.objects(Meal.self).where{$0.fav == true && $0.strMeal == meal.strMeal}
        if savedMeals.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    func deleteMealFromFav(meal: Meal){
        var foundMealsArr: [Meal] = []
        let savedMeals = db.objects(Meal.self).where{$0.fav == true && $0.strMeal == meal.strMeal}
        for meal in savedMeals{
            foundMealsArr.append(prepareNewMeal(meal: meal))
        }
        try! db.write({
            db.delete(savedMeals)
        })
        if !foundMealsArr.isEmpty {
            if foundMealsArr.first?.sat == true || foundMealsArr.first?.sun == true || foundMealsArr.first?.mon == true || foundMealsArr.first?.tue == true || foundMealsArr.first?.wed == true || foundMealsArr.first?.thu == true || foundMealsArr.first?.fri == true {
                foundMealsArr.first?.fav = false
                try! db.write({
                    db.create(Meal.self, value: foundMealsArr[0])
                })
            }
        }
    }
    
    func getDayMeals(day: WeekDays) -> [Meal]{
        var mealArrayToReturn: [Meal] = []
        switch day{
        case .sat:
            let arr = db.objects(Meal.self).where{$0.sat == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        case .sun:
            let arr = db.objects(Meal.self).where{$0.sun == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        case .mon:
            let arr = db.objects(Meal.self).where{$0.mon == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        case .tue:
            let arr = db.objects(Meal.self).where{$0.tue == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        case .wed:
            let arr = db.objects(Meal.self).where{$0.wed == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        case .thu:
            let arr = db.objects(Meal.self).where{$0.thu == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        case .fri:
            let arr = db.objects(Meal.self).where{$0.fri == true}
            for meal in arr{
                mealArrayToReturn.append(prepareNewMeal(meal: meal))
            }
        }
        return mealArrayToReturn
    }
    
    
    func addMealToWeekPlan(day: WeekDays, meal: Meal){
        var foundMealsArr: [Meal] = []
        let savedMeals = db.objects(Meal.self).where{$0.strMeal == meal.strMeal}
        for meal in savedMeals{
            foundMealsArr.append(prepareNewMeal(meal: meal))
        }
        try! db.write({
            db.delete(savedMeals)
        })
        if !foundMealsArr.isEmpty{
            switch day{
            case .sat:
                foundMealsArr[0].sat = true
            case .sun:
                foundMealsArr[0].sun = true
            case .mon:
                foundMealsArr[0].mon = true
            case .tue:
                foundMealsArr[0].tue = true
            case .wed:
                foundMealsArr[0].wed = true
            case .thu:
                foundMealsArr[0].thu = true
            case .fri:
                foundMealsArr[0].fri = true
            }
            try! db.write({
                db.create(Meal.self, value: foundMealsArr[0])
            })
        }else{
            let mealToBeAdded = meal
            switch day{
            case .sat:
                mealToBeAdded.sat = true
                mealToBeAdded.sun = false
                mealToBeAdded.mon = false
                mealToBeAdded.tue = false
                mealToBeAdded.wed = false
                mealToBeAdded.thu = false
                mealToBeAdded.fri = false
                mealToBeAdded.fav = false
            case .sun:
                mealToBeAdded.sat = false
                mealToBeAdded.sun = true
                mealToBeAdded.mon = false
                mealToBeAdded.tue = false
                mealToBeAdded.wed = false
                mealToBeAdded.thu = false
                mealToBeAdded.fri = false
                mealToBeAdded.fav = false
            case .mon:
                mealToBeAdded.sat = false
                mealToBeAdded.sun = false
                mealToBeAdded.mon = true
                mealToBeAdded.tue = false
                mealToBeAdded.wed = false
                mealToBeAdded.thu = false
                mealToBeAdded.fri = false
                mealToBeAdded.fav = false
            case .tue:
                mealToBeAdded.sat = false
                mealToBeAdded.sun = false
                mealToBeAdded.mon = false
                mealToBeAdded.tue = true
                mealToBeAdded.wed = false
                mealToBeAdded.thu = false
                mealToBeAdded.fri = false
                mealToBeAdded.fav = false
            case .wed:
                mealToBeAdded.sat = false
                mealToBeAdded.sun = false
                mealToBeAdded.mon = false
                mealToBeAdded.tue = false
                mealToBeAdded.wed = true
                mealToBeAdded.thu = false
                mealToBeAdded.fri = false
                mealToBeAdded.fav = false
            case .thu:
                mealToBeAdded.sat = false
                mealToBeAdded.sun = false
                mealToBeAdded.mon = false
                mealToBeAdded.tue = false
                mealToBeAdded.wed = false
                mealToBeAdded.thu = true
                mealToBeAdded.fri = false
                mealToBeAdded.fav = false
            case .fri:
                mealToBeAdded.sat = false
                mealToBeAdded.sun = false
                mealToBeAdded.mon = false
                mealToBeAdded.tue = false
                mealToBeAdded.wed = false
                mealToBeAdded.thu = false
                mealToBeAdded.fri = true
                mealToBeAdded.fav = false
            }
            try! db.write({
                db.create(Meal.self, value: mealToBeAdded)
            })
        }
    }
    
    func deleteMealFromWeekPlan(day: WeekDays, meal: Meal){
        var foundMealsArr: [Meal] = []
        let savedMeals = db.objects(Meal.self).where{$0.strMeal == meal.strMeal}
        for meal in savedMeals{
            foundMealsArr.append(prepareNewMeal(meal: meal))
        }
        try! db.write({
            db.delete(savedMeals)
        })
        if !foundMealsArr.isEmpty {
            switch day{
            case .sat:
                if foundMealsArr[0].fav == true || foundMealsArr[0].sun == true || foundMealsArr[0].mon == true || foundMealsArr[0].tue == true || foundMealsArr[0].wed == true || foundMealsArr[0].thu == true || foundMealsArr[0].fri == true {
                    foundMealsArr[0].sat = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            case .sun:
                if foundMealsArr[0].sat == true || foundMealsArr[0].fav == true || foundMealsArr[0].mon == true || foundMealsArr[0].tue == true || foundMealsArr[0].wed == true || foundMealsArr[0].thu == true || foundMealsArr[0].fri == true {
                    foundMealsArr[0].sun = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            case .mon:
                if foundMealsArr[0].sat == true || foundMealsArr[0].sun == true || foundMealsArr[0].fav == true || foundMealsArr[0].tue == true || foundMealsArr[0].wed == true || foundMealsArr[0].thu == true || foundMealsArr[0].fri == true {
                    foundMealsArr[0].mon = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            case .tue:
                if foundMealsArr[0].sat == true || foundMealsArr[0].sun == true || foundMealsArr[0].mon == true || foundMealsArr[0].fav == true || foundMealsArr[0].wed == true || foundMealsArr[0].thu == true || foundMealsArr[0].fri == true {
                    foundMealsArr[0].tue = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            case .wed:
                if foundMealsArr[0].sat == true || foundMealsArr[0].sun == true || foundMealsArr[0].mon == true || foundMealsArr[0].tue == true || foundMealsArr[0].fav == true || foundMealsArr[0].thu == true || foundMealsArr[0].fri == true {
                    foundMealsArr[0].wed = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            case .thu:
                if foundMealsArr[0].sat == true || foundMealsArr[0].sun == true || foundMealsArr[0].mon == true || foundMealsArr[0].tue == true || foundMealsArr[0].wed == true || foundMealsArr[0].fav == true || foundMealsArr[0].fri == true {
                    foundMealsArr[0].thu = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            case .fri:
                if foundMealsArr[0].sat == true || foundMealsArr[0].sun == true || foundMealsArr[0].mon == true || foundMealsArr[0].tue == true || foundMealsArr[0].wed == true || foundMealsArr[0].thu == true || foundMealsArr[0].fav == true {
                    foundMealsArr[0].fri = false
                    try! db.write({
                        db.create(Meal.self, value: foundMealsArr[0])
                    })
                }
            }
        }
    }
    
    func checkMealIsAlreadyPickedForTheDay(day: WeekDays, meal: Meal) -> Bool{
        let meal = db.objects(Meal.self).where{$0.strMeal == meal.strMeal}
        if meal.isEmpty {
            return false
        }else{
            switch day{
            case .sat:
                if meal[0].sat == true {
                    return true
                }
            case .sun:
                if meal[0].sun == true {
                    return true
                }
            case .mon:
                if meal[0].mon == true {
                    return true
                }
            case .tue:
                if meal[0].tue == true {
                    return true
                }
            case .wed:
                if meal[0].wed == true {
                    return true
                }
            case .thu:
                if meal[0].thu == true {
                    return true
                }
            case .fri:
                if meal[0].fri == true {
                    return true
                }
            }
            return false
        }
    }
    
    
    func prepareNewMeal(meal: Meal) -> Meal{
        let freshMeal = Meal(value: ["idMeal": meal.idMeal])
        freshMeal.strMeal = meal.strMeal
        freshMeal.strCategory = meal.strCategory
        freshMeal.strArea = meal.strArea
        freshMeal.strInstructions = meal.strInstructions
        freshMeal.strMealThumb = meal.strMealThumb
        freshMeal.strTags = meal.strTags
        freshMeal.strYoutube = meal.strYoutube
        freshMeal.strIngredient1 = meal.strIngredient1
        freshMeal.strIngredient2 = meal.strIngredient2
        freshMeal.strIngredient3 = meal.strIngredient3
        freshMeal.strIngredient4 = meal.strIngredient4
        freshMeal.strIngredient5 = meal.strIngredient5
        freshMeal.strIngredient6 = meal.strIngredient6
        freshMeal.strIngredient7 = meal.strIngredient7
        freshMeal.strIngredient8 = meal.strIngredient8
        freshMeal.strIngredient9 = meal.strIngredient9
        freshMeal.strIngredient10 = meal.strIngredient10
        freshMeal.strIngredient11 = meal.strIngredient11
        freshMeal.strIngredient12 = meal.strIngredient12
        freshMeal.strIngredient13 = meal.strIngredient13
        freshMeal.strIngredient14 = meal.strIngredient14
        freshMeal.strIngredient15 = meal.strIngredient15
        freshMeal.strIngredient16 = meal.strIngredient16
        freshMeal.strIngredient17 = meal.strIngredient17
        freshMeal.strIngredient18 = meal.strIngredient18
        freshMeal.strIngredient19 = meal.strIngredient19
        freshMeal.strIngredient20 = meal.strIngredient20
        freshMeal.strMeasure1 = meal.strMeasure1
        freshMeal.strMeasure2 = meal.strMeasure2
        freshMeal.strMeasure3 = meal.strMeasure3
        freshMeal.strMeasure4 = meal.strMeasure4
        freshMeal.strMeasure5 = meal.strMeasure5
        freshMeal.strMeasure6 = meal.strMeasure6
        freshMeal.strMeasure7 = meal.strMeasure7
        freshMeal.strMeasure8 = meal.strMeasure8
        freshMeal.strMeasure9 = meal.strMeasure9
        freshMeal.strMeasure10 = meal.strMeasure10
        freshMeal.strMeasure11 = meal.strMeasure11
        freshMeal.strMeasure12 = meal.strMeasure12
        freshMeal.strMeasure13 = meal.strMeasure13
        freshMeal.strMeasure14 = meal.strMeasure14
        freshMeal.strMeasure15 = meal.strMeasure15
        freshMeal.strMeasure16 = meal.strMeasure16
        freshMeal.strMeasure17 = meal.strMeasure17
        freshMeal.strMeasure18 = meal.strMeasure18
        freshMeal.strMeasure19 = meal.strMeasure19
        freshMeal.strMeasure20 = meal.strMeasure20
        freshMeal.fav = meal.fav
        freshMeal.sat = meal.sat
        freshMeal.sun = meal.sun
        freshMeal.mon = meal.mon
        freshMeal.tue = meal.tue
        freshMeal.wed = meal.wed
        freshMeal.thu = meal.thu
        freshMeal.fri = meal.fri
        return freshMeal
    }
}
