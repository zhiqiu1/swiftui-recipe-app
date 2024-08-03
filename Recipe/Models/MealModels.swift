//
//  MealModels.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct MealDetail: Codable {
    let id: String
    let name: String
    let instructions: String
    let category: String?
    let area: String?
    let thumbnail: String?
    let youtube: String?
    let source: String?
    let imageSource: String?
    let ingredient1, ingredient2, ingredient3, ingredient4, ingredient5: String?
    let ingredient6, ingredient7, ingredient8, ingredient9, ingredient10: String?
    let ingredient11, ingredient12, ingredient13, ingredient14, ingredient15: String?
    let ingredient16, ingredient17, ingredient18, ingredient19, ingredient20: String?
    let measure1, measure2, measure3, measure4, measure5: String?
    let measure6, measure7, measure8, measure9, measure10: String?
    let measure11, measure12, measure13, measure14, measure15: String?
    let measure16, measure17, measure18, measure19, measure20: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case category = "strCategory"
        case area = "strArea"
        case thumbnail = "strMealThumb"
        case youtube = "strYoutube"
        case source = "strSource"
        case imageSource = "strImageSource"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
    
    var ingredientsWithMeasurements: [String] {
        let ingredientsArray = [ingredient1, ingredient2, ingredient3, ingredient4, ingredient5,
                                ingredient6, ingredient7, ingredient8, ingredient9, ingredient10,
                                ingredient11, ingredient12, ingredient13, ingredient14, ingredient15,
                                ingredient16, ingredient17, ingredient18, ingredient19, ingredient20]
        
        let measurementsArray = [measure1, measure2, measure3, measure4, measure5,
                                 measure6, measure7, measure8, measure9, measure10,
                                 measure11, measure12, measure13, measure14, measure15,
                                 measure16, measure17, measure18, measure19, measure20]
        
        var ingredientsWithMeasurements: [String] = []
        
        for (ingredient, measurement) in zip(ingredientsArray, measurementsArray) {
            if let ingredient = ingredient, !ingredient.isEmpty, let measurement = measurement, !measurement.isEmpty {
                ingredientsWithMeasurements.append("\(ingredient): \(measurement)")
            }
        }
        
        return ingredientsWithMeasurements
    }
}
