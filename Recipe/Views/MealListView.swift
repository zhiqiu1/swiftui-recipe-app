//
//  ContentView.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import SwiftUI
import Kingfisher

struct MealListView: View {
    @StateObject private var viewModel: MealListViewModel
    @State private var selectedMealID: String?
    
    init(mealService: MealService = MealService()) {
        _viewModel = StateObject(wrappedValue: MealListViewModel(mealService: mealService))
    }

    var body: some View {
        NavigationSplitView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage, retryAction: {
                        Task {
                            await viewModel.fetchMeals()
                        }
                    })
                } else {
                    List(viewModel.meals, selection: $selectedMealID) { meal in
                        MealRowView(meal: meal)
                    }
                    .refreshable {
                        await viewModel.fetchMeals()
                    }
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchMeals()
            }
        } detail: {
            if let selectedMealID = selectedMealID {
                MealDetailView(mealID: selectedMealID, mealService: viewModel.mealService)
            } else {
                Text("Select a meal")
                    .foregroundStyle(.gray)
            }
        }
    }
}

struct MealRowView: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            KFImage(URL(string: meal.thumbnail))
                .resizable()
                .placeholder {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                .frame(width: 50, height: 50)
                .clipShape(.rect(cornerRadius: 8))
            
            Text(meal.name)
                .font(.headline)
        }
    }
}

#Preview {
    MealListView(mealService: MealService())
}
