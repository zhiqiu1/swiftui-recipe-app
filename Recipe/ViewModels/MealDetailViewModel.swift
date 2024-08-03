//
//  MealDetailViewModel.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var errorMessage: String?
    @Published var isLoading = true
    private let mealService: MealService

    init(mealService: MealService) {
        self.mealService = mealService
    }

    func fetchMealDetail(mealID: String) async {
        mealDetail = nil
        defer {
            self.isLoading = false
        }
        self.isLoading = true
        do {
            let fetchedMealDetail = try await mealService.fetchMealDetail(mealID: mealID)
            self.mealDetail = fetchedMealDetail
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Failed to fetch meal detail: \(error.localizedDescription)"
        }
    }
}
