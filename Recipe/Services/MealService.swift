//
//  MealService.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation

class MealService {
    private let baseURL: String
    
    init(baseURL: String = "https://themealdb.com/api/json/v1/1/") {
        self.baseURL = baseURL
    }
    
    func fetchMeals() async throws -> [Meal] {
        let urlString = "\(baseURL)filter.php?c=Dessert"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealResponse = try JSONDecoder().decode([String: [Meal]].self, from: data)
        guard let meals = mealResponse["meals"]?.sorted(by: { $0.name < $1.name }) else { throw URLError(.badServerResponse) }
        return meals
    }
    
    func fetchMealDetail(mealID: String) async throws -> MealDetail {
        let urlString = "\(baseURL)lookup.php?i=\(mealID)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetailResponse = try JSONDecoder().decode([String: [MealDetail]].self, from: data)
        guard let mealDetail = mealDetailResponse["meals"]?.first else { throw URLError(.badServerResponse) }
        return mealDetail
    }
}
