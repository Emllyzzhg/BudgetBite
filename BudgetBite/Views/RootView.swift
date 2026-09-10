//
//  RootView.swift
//  BudgetBite
//
//  Created by emily zhang on 10/9/2026.
//

import SwiftUI
 
struct RootView: View {
    
    @StateObject private var budgetViewModel: BudgetViewModel
    @StateObject private var ingredientViewModel: IngredientViewModel
    @StateObject private var mealPlanViewModel = MealPlanViewModel()
    @StateObject private var mealRecommendationViewModel: MealRecommendationViewModel
    
    init() {
        
        let ingredientRepository = LocalIngredientRepository()
        let recipeRepository = LocalRecipeRepository()
        
        let initialBudget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 20.00
        )
        
        let budgetUseCase = UpdateFoodBudgetUseCase()
        
        _budgetViewModel = StateObject(
            wrappedValue: BudgetViewModel(
                budget: initialBudget,
                updateBudgetUseCase: budgetUseCase
            )
        )
        
        _ingredientViewModel = StateObject(
            wrappedValue: IngredientViewModel(
                repository: ingredientRepository
            )
        )
        
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
                    MealRecommendationsView(
                        viewModel: mealRecommendationViewModel
                    )
                }
            }
            
            Tab("My Plan", systemImage: "calendar") {
                MealPlanView()
            }
        }
        .environmentObject(budgetViewModel)
        .environmentObject(ingredientViewModel)
        .environmentObject(mealPlanViewModel)
    }
}
 
#Preview {
    RootView()
}
