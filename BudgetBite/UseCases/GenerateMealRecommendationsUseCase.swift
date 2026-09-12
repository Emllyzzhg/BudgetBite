//
//  GenerateMealRecommendationsUseCase.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
/// Use Case 3: generates meal recommendations based on a student's remaining food budget and the ingredients they currently have available
/// 
/// Business rules:
/// 1. A recipe must be affordable based on the student's remaining budget
/// 2. Recipes using ingredients the student already has are prioritised
/// 3. Recipes that require ingredients the student does not have may still be recommended if they are affordable
/// 4. Ingredient names are normalised so that differences such as "Carrot", "CARROT" and "Carrots" are treated as the same ingredient.
struct GenerateMealRecommendationsUseCase { /// Business logic: given the student's remaining budget and available ingredients, which recipes should be recommended?
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
    func execute(budget: Budget) throws -> [MealRecommendation] { /// Function that generates recipe recommendations and prioritises recipes that use ingredients the student already has
        let availableIngredientNames = Set(
            ingredientRepository.ingredients.map {
                normaliseIngredientName($0.name)
            }
        )
        let recommendations = recipeRepository.recipes.compactMap { recipe -> MealRecommendation? in
            let costToBuy = recipe.ingredients
                .filter { ingredient in
                    !availableIngredientNames.contains(
                        normaliseIngredientName(ingredient.name)
                    )
                }
                .reduce(0) { total, ingredient in
                    total + ingredient.price
                }
            
            if costToBuy <= budget.remainingBudget {
                return MealRecommendation(
                    recipe: recipe,
                    costToBuy: costToBuy
                )
            } else {
                return nil
            }
        }
        guard !recommendations.isEmpty else { /// Checks there is at least one affordable recipe in array otherwise stop and throw error
            throw RecommendationError.noAffordableMeals
        }
        
        return recommendations.sorted { recommendation1, recommendation2 in /// Sort affordable recipes and sort them by the number of ingredients the student already has
            let recipe1Matches = recommendation1.recipe.ingredients.filter {
                ingredient in availableIngredientNames.contains(
                    normaliseIngredientName(ingredient.name)
                )
            }.count
            let recipe2Matches = recommendation2.recipe.ingredients.filter {
                ingredient in availableIngredientNames.contains(
                    normaliseIngredientName(ingredient.name)
                )
            }.count
            return recipe1Matches > recipe2Matches /// If the recipe has more matching ingredients, put it before the recipe with less matching ingredients
        }
    }
}
/// Normalises ingredient names so that differences such as "Carrot", "CARROT" and "Carrots" are treated as the same ingredient
    private func normaliseIngredientName(_ name: String) -> String {
        var ingredientName = name.lowercased()
        ingredientName = ingredientName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        if ingredientName.hasSuffix("s") {
            ingredientName = String(ingredientName.dropLast())
        }
        return ingredientName
    }
