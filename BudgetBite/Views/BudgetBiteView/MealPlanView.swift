//
//  MealPlanView.swift
//  BudgetBite
//
//  Created by emily zhang on 10/9/2026.
//

import SwiftUI
 
/// This view displays the meals that the user has planned

/// Defines MealPlanView as a SwiftUI view
struct MealPlanView: View {
    
    /// Gets access to the MealPlanViewModel so that it displays the student's planned meals and the functions needed to manage them
    @EnvironmentObject private var mealPlanViewModel: MealPlanViewModel
    
    /// Defines user interface displayed by this view
    var body: some View {
        /// Creates a list to display the student's planned meals
        List {
            /// Checks whether the student's meal plan contains any meals
            if mealPlanViewModel.plannedMeals.isEmpty {
                /// Displays a message when there are no meals in the meal plan
                ContentUnavailableView(
                    "No Meals Planned",
                    systemImage: "calendar",
                    description: Text(
                        "Choose meals from Meal Suggestions to build your weekly plan."
                    )
                )
            ///  If the meal plan is not empty, the app displays the planned meals
            } else {
                /// Goes through the planned meals stored in mealPlanViewModel.plannedMeals and displays each meal
                ForEach(mealPlanViewModel.plannedMeals) { meal in
                    VStack(alignment: .leading, spacing: 4) {
                        /// Displays the meal name, planned date, and estimated cost in AUD for each planned meal
                        Text(meal.recipe.name)
                            .font(.headline)
                        
                        Text(meal.plannedDate, style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Text(
                            meal.recipe.estimatedCost,
                            format: .currency(code: "AUD")
                        )
                        .font(.subheadline)
                    }
                }
                /// Adds swipe-to-delete functionality to the ingredient list. It identifies the position of the ingredient that the student wants to delete
                .onDelete { indexSet in
                    for index in indexSet {
                        let meal = mealPlanViewModel.plannedMeals[index]
                        mealPlanViewModel.delete(meal)
                    }
                }
            }
        }
        .navigationTitle("My Meal Plan")
    }
}
