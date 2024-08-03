//
//  MealServiceTests.swift
//  MealServiceTests
//
//  Created by Zhi Qiu on 8/1/24.
//

import XCTest
@testable import Recipe

class MealServiceTests: XCTestCase {
    private var mealService: MealService = MealService()
    
    func testFetchMeals() async throws {
        let meals = try await mealService.fetchMeals()
        XCTAssertFalse(meals.isEmpty)
    }
    
    func testFetchMealDetail() async throws {
        let mealID = "52772"
        let mealDetail = try await mealService.fetchMealDetail(mealID: mealID)
        XCTAssertEqual(mealDetail.id, mealID)
    }
    
    func testFetchMealsInvalidURL() async {
        mealService = MealService(baseURL: "invalidURL")
        do {
            _ = try await mealService.fetchMeals()
            XCTFail("Expected to throw an error, but no error was thrown")
        } catch {
            XCTAssertTrue(error is URLError, "Expected URLError, got \(error)")
        }
    }
}
