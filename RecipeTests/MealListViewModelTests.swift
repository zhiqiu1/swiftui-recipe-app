//
//  MealListViewModelTests.swift
//  RecipeTests
//
//  Created by Zhi Qiu on 8/2/24.
//

import XCTest
@testable import Recipe

class MealListViewModelTests: XCTestCase {
    private var viewModel: MealListViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        
        let mealService = MealService()
        viewModel = MealListViewModel(mealService: mealService)
    }
    
    func testInitialState() async {
        await MainActor.run {
            XCTAssertTrue(viewModel.meals.isEmpty)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertTrue(viewModel.isLoading)
        }
    }
    
    func testFetchMeals() async {
        await viewModel.fetchMeals()
        await MainActor.run {
            XCTAssertFalse(viewModel.meals.isEmpty)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }
    
    func testFetchMealsError() async {
        let invalidService = MealService(baseURL: "invalidURL")
        viewModel = await MealListViewModel(mealService: invalidService)
        await viewModel.fetchMeals()
        await MainActor.run {
            XCTAssertTrue(viewModel.meals.isEmpty)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }
}
