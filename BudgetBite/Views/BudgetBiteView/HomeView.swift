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
    
    @State private var showingBudgetEditor = false
    @State private var newBudgetAmount = ""
    @State private var budgetErrorMessage: String?
    
    /// Defines user interface displayed by this view
    var body: some View {
        /// Creates a navigation container to move from the home screen to other views in the app
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    /// Displays the heading "Remaining Food Budget" and the font
                    Text("Welcome, BudgetBite")
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
                
                if let errorMessage = budgetViewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Button("Edit Weekly Budget", systemImage: "pencil") {
                    budgetErrorMessage = nil
                    newBudgetAmount = String(
                        format: "%.2f", budgetViewModel.budget.weeklyBudget
                    )
                    showingBudgetEditor = true
                }
                .buttonStyle(.bordered)
                
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
            .sheet(isPresented: $showingBudgetEditor){
                NavigationStack {
                    Form {
                        Section("Weekly Food Budget"){
                            /// Explains that changing the weekly budget will reset the remaining budget.
                            Text("Changing your weekly budget will reset your remaining budget.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            TextField("Budget amount", text: $newBudgetAmount
                            )
                            .keyboardType(.decimalPad)
                            
                            if let budgetErrorMessage = budgetErrorMessage {
                                Text(budgetErrorMessage)
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            }
                        }
                        Section {
                            Button("Save Budget") {
                                if let amount = Double(newBudgetAmount), amount > 0 {
                                    budgetErrorMessage = nil
                                    budgetViewModel.setWeeklyBudget (amount)
                                    if budgetViewModel.errorMessage == nil {
                                        showingBudgetEditor = false
                                    }
                                } else {
                                    budgetErrorMessage = "Please enter a valid budget greater than $0."
                                }
                            }
                        }
                    }
                    .navigationTitle("Edit Budget")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingBudgetEditor = false
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
