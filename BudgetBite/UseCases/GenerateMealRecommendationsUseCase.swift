//
//  GenerateMealRecommendationsUseCase.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
/// Use Case 3: generates meal recommendations based on a student's remaining food budget and the ingredients they currently have available. Repository gives use case recipes so it can apply the business rules
/// 
/// Business rules:
/// 1. A recipe must be affordable based on the student's remaining budget
/// 2. Recipes using ingredients the student already has are prioritised
/// 3. Recipes that require ingredients the student does not have may still be recommended if they are affordable

struct GenerateMealRecommendationsUseCase { // Business logic: given the student's remaining budget and available ingredients, which recipes should be recommended?
    enum RecommendationError: LocalizedError, Equatable {
        case noAffordableMeals
        var errorDescription: String? {
            switch self {
            case .noAffordableMeals:
                return "No meals currently fit your remaining food budget. Try adding more available ingredients or increasing your budget."
            }
        }
    }
    let recipeRepository: RecipeRepository
    let ingredientRepository: IngredientRepository
    func execute( // Function that generates recipe recommendations
        budget: Budget
    ) throws -> [Recipe] {
        let affordableRecipes = recipeRepository.recipes.filter { // From array of recipes, keep only ones that cost less than or equal to the remaining budget
            recipe in recipe.estimatedCost <= budget.remainingBudget
        }
        guard !affordableRecipes.isEmpty else { // Checks there is at least one affordable recipe in array otherwise stop and throw error
            throw RecommendationError.noAffordableMeals
        }
        let availableIngredientNames = Set( // Checks the list of avaliable ingredient names for matching below
            ingredientRepository.ingredients.map {
                ingredient in ingredient.name.lowercased()
            }
        )
        return affordableRecipes.sorted { recipe1, recipe2 in // Sort affordable recipes and sort them by the number of ingredients the student already has
            let recipe1Matches = recipe1.ingredients.filter {
                ingredient in availableIngredientNames.contains(ingredient.lowercased())
            }.count
            let recipe2Matches = recipe2.ingredients.filter {
                ingredient in availableIngredientNames.contains(ingredient.lowercased())
            }.count
            return recipe1Matches > recipe2Matches // If the recipe has more matching ingredients, put it before the recipe with less matching ingredients
        }
    }
}
