//
//  MealDetailViewModelTests.swift
//  RecipeTests
//
//  Created by Zhi Qiu on 8/2/24.
//

import XCTest
@testable import Recipe

class MealDetailViewModelTests: XCTestCase {
    private var viewModel: MealDetailViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        
        let mealService = MealService()
        viewModel = MealDetailViewModel(mealService: mealService)
    }
    
    func testInitialState() async{
        await MainActor.run {
            XCTAssertNil(viewModel.mealDetail)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertTrue(viewModel.isLoading)
        }
    }
    
    func testFetchMealDetailSuccess() async {
        let mealID = "52772"
        await viewModel.fetchMealDetail(mealID: mealID)
        await MainActor.run {
            XCTAssertNotNil(viewModel.mealDetail)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }
    
    func testFetchMealDetailError() async {
        let invalidMealID = "invalidMealID"
        await viewModel.fetchMealDetail(mealID: invalidMealID)
        await MainActor.run {
            XCTAssertNil(viewModel.mealDetail)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }
}
