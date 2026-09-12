//
//  RootView.swift
//  BudgetBite
//
//  Created by emily zhang on 10/9/2026.
//

import SwiftUI
 
/// This view is for setting up the app and connecting the different views and view models together

/// Defines RootView as the main/root view of the application. It connects the different screens and view models together
struct RootView: View {
    
    /// Creates and manages the view models used throughout the application
    @StateObject private var budgetViewModel: BudgetViewModel
    @StateObject private var ingredientViewModel: IngredientViewModel
    @StateObject private var mealPlanViewModel = MealPlanViewModel()
    @StateObject private var mealRecommendationViewModel: MealRecommendationViewModel
    
    /// Initialises the RootView and sets up the repositories, budget, and view models required by the application
    init() {
        /// Creates the local repositories used to access ingredient and recipe data
        let ingredientRepository = LocalIngredientRepository()
        let recipeRepository = LocalRecipeRepository()
        /// Creates the initial food budget with a weekly budget of $50.00 and a remaining budget of $20.00
        let initialBudget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 20.00
        )
        /// Creates the use case responsible for updating the user's food budget
        let budgetUseCase = UpdateFoodBudgetUseCase()
        let restoreBudgetUseCase = RestoreFoodBudgetUseCase()
        let setBudgetUseCase = SetWeeklyBudgetUseCase()
        /// Creates the BudgetViewModel using the initial budget and budget update use case
        _budgetViewModel = StateObject(
            wrappedValue: BudgetViewModel(
                budget: initialBudget,
                updateBudgetUseCase: budgetUseCase,
                restoreFoodBudgetUseCase: restoreBudgetUseCase,
                setWeeklyBudgetUseCase: setBudgetUseCase
            )
        )
        /// Creates the IngredientViewModel and connects it to the local ingredient repository so that ingredients can be managed
        _ingredientViewModel = StateObject(
            wrappedValue: IngredientViewModel(
                repository: ingredientRepository
            )
        )
        /// Creates the MealRecommendationViewModel and connects it to the GenerateMealRecommendationsUseCase, with the recipe and ingredient repositories provide the required data
        _mealRecommendationViewModel = StateObject(
            wrappedValue: MealRecommendationViewModel(
                generateRecommendationsUseCase:
                    GenerateMealRecommendationsUseCase(
                        recipeRepository: recipeRepository,
                        ingredientRepository: ingredientRepository
                    )
            )
        )
    }
    
    var body: some View {
        
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Ingredients", systemImage: "refrigerator") {
                IngredientsView()
            }
            
            Tab("Meals", systemImage: "fork.knife") {
                NavigationStack {
                    MealRecommendationsView()
                }
            }
            
            Tab("My Plan", systemImage: "calendar") {
                MealPlanView()
            }
        }
        .environmentObject(budgetViewModel)
        .environmentObject(ingredientViewModel)
        .environmentObject(mealPlanViewModel)
        .environmentObject(mealRecommendationViewModel)
    }
}
 
#Preview {
    RootView()
}
