//
//  MealService.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation

class MealService {
    private let baseURL: String
    private let apiClient: APIClient
    
    init(baseURL: String = "https://themealdb.com/api/json/v1/1/", apiClient: APIClient = APIClient()) {
        self.baseURL = baseURL
        self.apiClient = apiClient
    }
    
    func fetchMeals() async throws -> [Meal] {
        let urlString = "\(baseURL)filter.php?c=Dessert"
        let mealResponse: [String: [Meal]] = try await apiClient.fetchData(from: urlString, decodingType: [String: [Meal]].self)
        guard let meals = mealResponse["meals"]?.sorted(by: { $0.name < $1.name }) else { throw URLError(.badServerResponse) }
        return meals
    }
    
    func fetchMealDetail(mealID: String) async throws -> MealDetail {
        let urlString = "\(baseURL)lookup.php?i=\(mealID)"
        let mealDetailResponse: [String: [MealDetail]] = try await apiClient.fetchData(from: urlString, decodingType: [String: [MealDetail]].self)
        guard let mealDetail = mealDetailResponse["meals"]?.first else { throw URLError(.badServerResponse) }
        return mealDetail
    }
}
