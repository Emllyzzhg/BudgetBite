//
//  MealRecommendationsView.swift
//  BudgetBite
//
//  Created by emily zhang on 9/9/2026.
//

import SwiftUI
 
struct MealRecommendationsView: View {
    
    @EnvironmentObject private var budgetViewModel: BudgetViewModel
    @EnvironmentObject private var mealRecommendationViewModel:MealRecommendationViewModel
    @EnvironmentObject private var mealPlanViewModel: MealPlanViewModel
    
    var body: some View {
        List {
            if mealRecommendationViewModel.recommendations.isEmpty {
                ContentUnavailableView(
                    "No Meal Suggestions",
                    systemImage: "fork.knife.circle",
                    description: Text(
                        mealRecommendationViewModel.errorMessage ??
                        "No meals are currently available."
                    )
                )
            } else {
                
                ForEach(mealRecommendationViewModel.recommendations) { recipe in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.name)
                            .font(.headline)
                        
                        Text(
                            recipe.estimatedCost,
                            format: .currency(code: "AUD")
                        )
                        .font(.subheadline)
                        
                        Text(recipe.ingredients.joined(separator: ", "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        
                        Button("Add to Meal Plan") {
                            
                            mealPlanViewModel.add(
                                MealPlanEntry(
                                    recipe: recipe,
                                    plannedDate: Date()
                                )
                            )
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Meal Suggestions")
        .onAppear {
            viewModel.generateRecommendations(
                budget: budgetViewModel.budget
            )
        }
    }
}
