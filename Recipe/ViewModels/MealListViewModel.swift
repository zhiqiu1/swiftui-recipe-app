//
//  MealListViewModel.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String?
    @Published var isLoading = true
    let mealService: MealService

    init(mealService: MealService = MealService()) {
        self.mealService = mealService
    }

    func fetchMeals() async {
        guard meals.isEmpty else { return }
        defer {
            self.isLoading = false
        }
        self.isLoading = true
        do {
            let fetchedMeals = try await mealService.fetchMeals()
            self.meals = fetchedMeals
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Failed to fetch meals: \(error.localizedDescription)"
        }
    }
}
