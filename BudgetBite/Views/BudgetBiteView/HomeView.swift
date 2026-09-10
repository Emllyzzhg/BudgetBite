//
//  HomeView.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import SwiftUI

struct HomeView: View {
   
    @EnvironmentObject private var budgetViewModel: BudgetViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Remaining Food Budget")
                        .font(.headline)
                    Text(budgetViewModel.budget.remainingBudget,format:.currency(code: "AUD")
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                    Text(
                        "Weekly budget: " + budgetViewModel.budget.weeklyBudget.formatted(.currency(code: "AUD"))
                        )
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                
                NavigationLink {MealRecommendationsView()
                } label: {
                    Label("View Meal Suggestions",systemImage: "fork.knife")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink {
                    IngredientsView()
                } label: {
                    Label("My Ingredients",systemImage: "refigerator")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
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
