//
//  HomeView.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import SwiftUI

/// HomeView is the home view of BudgetBite. It provides student with an overview of their remaining weekly food budget and navigation to the main features of the app

/// Defines HomeView as a SwiftUI view
struct HomeView: View {
   
    /// Gets access to the BudgetViewModel so that it displays the student's current food budget information
    @EnvironmentObject private var budgetViewModel: BudgetViewModel
    
    /// Defines user interface displayed by this view
    var body: some View {
        /// Creates a navigation container to move from the home screen to other views in the app
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    /// Displays the heading "Remaining Food Budget" and the font
                    Text("Remaining Food Budget")
                        .font(.headline)
                    /// Displays the student's remaining food budget in AUD
                    Text(budgetViewModel.budget.remainingBudget,format:.currency(code: "AUD")
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    /// Displays the student's total weekly budget underneath the remaining budget in AUD
                    Text(
                        "Weekly budget: " + budgetViewModel.budget.weeklyBudget.formatted(.currency(code: "AUD"))
                        )
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                
                /// Creates a navigation button labelled "View Meal Suggestions" which takes the student  to MealRecommendationsView
                NavigationLink {MealRecommendationsView()
                } label: {
                    Label("View Meal Suggestions",systemImage: "fork.knife")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                /// Creates a navigation button labelled "My Ingredients" which takes the student to IngredientsView
                NavigationLink {
                    IngredientsView()
                } label: {
                    Label("My Ingredients",systemImage: "refrigerator")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                /// Creates a navigation button labelled "My Meal Plan" which takes the student to MealPlanView
                NavigationLink {
                    MealPlanView()
                } label: {
                    Label("My Meal Plan",systemImage: "calendar")
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Food Budget")
        }
    }
}

#Preview {
    HomeView()
}
