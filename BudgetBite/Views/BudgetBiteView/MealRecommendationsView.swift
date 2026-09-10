//
//  MealRecommendationsView.swift
//  BudgetBite
//
//  Created by emily zhang on 9/9/2026.
//

import SwiftUI
 
/// This view displays meal suggestions based on the student's food budget

/// Defines MealRecommendationsView as a SwiftUI view
struct MealRecommendationsView: View {
    
    /// Gets access to the BudgetViewModel provides the student's budget, MealRecommendationViewModel manages meal suggestions, and MealPlanViewModel manages the student's meal plan, and the functions needed to manage them
    @EnvironmentObject private var budgetViewModel: BudgetViewModel
    @EnvironmentObject private var mealRecommendationViewModel:MealRecommendationViewModel
    @EnvironmentObject private var mealPlanViewModel: MealPlanViewModel
    
    /// Defines user interface displayed by this view
    var body: some View {
        /// Creates a list to display the available meal recommendations
        List {
            /// Checks whether there are any meal recommendations available
            if mealRecommendationViewModel.recommendations.isEmpty {
                /// Displays a message when there are no meal suggestions available
                ContentUnavailableView(
                    "No Meal Suggestions",
                    systemImage: "fork.knife.circle",
                    description: Text(
                        mealRecommendationViewModel.errorMessage ??
                        "No meals are currently available."
                    )
                )
                /// If meal recommendations are available, the recommended meals are displayed instead
            } else {
                /// Goes through the available meal recommendations and displays each recipe
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
                        
                        /// Creates an "Add to Meal Plan" button that allows the student to add the selected recipe to their meal plan
                        Button("Add to Meal Plan") {
                            /// Adds the selected recipe to the student's meal plan. The meal is assigned the current date as its planned date
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
        /// Generates meal recommendations when the view appears, using the student's current budget
        .onAppear {
            mealRecommendationViewModel.generateRecommendations(
                budget: budgetViewModel.budget
            )
        }
    }
}
