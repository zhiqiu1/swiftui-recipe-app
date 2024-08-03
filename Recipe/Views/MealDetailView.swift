//
//  MealDetailView.swift
//  Recipe
//
//  Created by Zhi Qiu on 8/1/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct MealDetailView: View {
    @StateObject private var viewModel: MealDetailViewModel
    let mealID: String

    init(mealID: String, mealService: MealService) {
        self.mealID = mealID
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(mealService: mealService))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20.0) {
                if viewModel.isLoading {
                    ProgressView()
                } else if let mealDetail = viewModel.mealDetail {
                    if let imageUrl = URL(string: mealDetail.thumbnail ?? "") {
                        KFImage(imageUrl)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 360)
                            .clipShape(.rect(cornerRadius: 15))
                            .shadow(radius: 10)
                    }
                    
                    Text(mealDetail.name)
                        .font(.largeTitle)
                    
                    if let category = mealDetail.category {
                        Text("Category: \(category)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    if let area = mealDetail.area {
                        Text("Cuisine: \(area)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    if let videoUrlString = mealDetail.youtube, let videoID = videoUrlString.split(separator: "=").last {
                        YouTubeView(videoID: String(videoID))
                            .aspectRatio(16/9, contentMode: .fit)
                            .clipShape(.rect(cornerRadius: 15))
                            .shadow(radius: 10)
                    }

                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top)
                    
                    ForEach(mealDetail.ingredientsWithMeasurements.indices, id: \.self) { index in
                        Text(mealDetail.ingredientsWithMeasurements[index])
                    }
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(mealDetail.instructions)
                    
                    if let sourceUrl = mealDetail.source, !sourceUrl.isEmpty {
                        Link("Recipe Source", destination: URL(string: sourceUrl)!)
                            .padding(.top)
                            .foregroundStyle(.blue)
                    }
                    
                    if let imageSource = mealDetail.imageSource, !imageSource.isEmpty {
                        Link("Image Source", destination: URL(string: imageSource)!)
                            .padding(.top)
                            .foregroundStyle(.blue)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage, retryAction: {
                        Task {
                            await viewModel.fetchMealDetail(mealID: mealID)
                        }
                    })
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.mealDetail?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMealDetail(mealID: mealID)
        }
        .onChange(of: mealID) {
            Task {
                await viewModel.fetchMealDetail(mealID: mealID)
            }
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049", mealService: MealService())
}
