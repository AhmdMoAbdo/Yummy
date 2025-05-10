//
//  Constants.swift
//  Yummy
//
//  Created by Ahmed Abdo on 09/05/2025.
//

import Foundation

enum Constants {
    enum Images {
        static let tabbarHome = "house"
        static let tabbarCategories = "list.bullet.below.rectangle"
        static let tabbarFavorite = "heart"
        static let tabbarWeekPlan = "calendar"
        static let weekPlanEmptyState = "emptyCalendar"
        static let favoriteEmptyState = "EmptyPlate"
        static let searchFindMeal = "FindMeal"
        static let searchNotItemsFound = "EmptyPlate"
        static let searchIcon = "magnifyingglass"
        static let homeCarouselImage = "repeat"
        static let detailsPlayIcon = "play.circle.fill"
        static let detailsCalendarIcon = "calendar"
        static let heartIcon = "heart.square.fill"
        static let detailsSelectedDayIndicator = "checkmark.seal.fill"
        static let mealDetailsInstuctionsSectionIcon = "list.clipboard.fill"
        static let mealDetailsIngredientsSectionIcon = "cart.fill"
        static let mealDetailsIngredientsGridIcon = "slider.horizontal.below.square.and.square.filled"
        static let mealDetailsIngredientsListIcon = "list.bullet"
        static let mealDetailsIngredientsListCellIcon = "oval.fill"
        static let headerSearchIcon = "magnifyingglass.circle.fill"
        static let backButton = "chevron.backward.circle.fill"
        static let mealCellDeleteIcon = "trash.circle.fill"
        static let mealCellForkIcon = "fork.knife"
        static let mealCellLocationIcon = "location"
    }
    
    enum LottieAnimation {
        static let home = "home"
        static let weekPlan = "calendar"
        static let favorite = "RBFav"
        static let category = "category"
        static let loader = "fork"
    }
    
    enum Tabbar {
        static let tabbarHome = "Home"
        static let tabbarCategories = "Categories"
        static let tabbarFavorite = "Favorite"
        static let tabbarWeekPlan = "Week Plan"
    }
    
    enum Home {
        static let pageHeader = "Home"
        static let forYouSectionHeader = "For You"
        static let trendingSectionHeader = "Trending"
        static let newDishesSectionHeader = "New Dishes"
    }
    
    enum WeekPlan {
        static let pageHeader = "Week Plan"
        static let emptyStateMessage = "No meals planned for today"
    }
    
    enum Favorite {
        static let pageHeader = "Favorites"
        static let emptyStateMessage = "No Favorite Meals Found"
    }
    
    enum Search {
        static let pageHeader = "Search"
        static let findNewMeals = "Lookup new meals"
        static let noMealsFound = "No Meals Found"
        static let searchHint = "Keyword"
    }
    
    enum Categories {
        static let pageHeader = "Menu"
        static let filterCategories = "Categories"
        static let filterIngredients = "Ingredients"
        static let filterCountries = "Countries"
    }
    
    enum MealDetails {
        static let instructions = "Instructions:"
        static let ingredients = "Ingredients:"
    }
    
    enum Alert {
        static let addedToFavorite = "Added to Favorite"
        static let removedFromFavorite =  "Removed From Favorite"
        static let ok = "OK"
        static let success = "Success"
        static let warning = "Wraning"
        static let delete = "Delete"
        static let add = "Add"
        static let cancel = "Cancel"
        static let addMealToFavorite = "Add $m to favorites?"
        static let deleteMealFromFavorite = "Remove $m from favorite?"
        static let deleteMealFromDayPlan = "Remove $m from $d's plan?"
    }
    
    enum MealCell {
        static let delete = "Delete"
    }
}
