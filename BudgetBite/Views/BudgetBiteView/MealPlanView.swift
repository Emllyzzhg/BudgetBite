//
//  MealPlanView.swift
//  BudgetBite
//
//  Created by emily zhang on 10/9/2026.
//

import SwiftUI
 
struct MealPlanView: View {
    
    @EnvironmentObject private var mealPlanViewModel: MealPlanViewModel
    
    var body: some View {
        List {
            
            if mealPlanViewModel.plannedMeals.isEmpty {
                
                ContentUnavailableView(
                    "No Meals Planned",
                    systemImage: "calendar",
                    description: Text(
                        "Choose meals from Meal Suggestions to build your weekly plan."
                    )
                )
                
            } else {
                
                ForEach(mealPlanViewModel.plannedMeals) { meal in
                    VStack(alignment: .leading, spacing: 4) {
                        
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
