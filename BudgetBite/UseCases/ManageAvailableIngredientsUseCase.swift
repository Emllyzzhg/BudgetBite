//
//  ManageAvailableIngredientsUseCase.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
/// Use Case 2: manages the ingredients currently available to a university student
/// 
/// Business rules:
/// 1. An ingredient must have a quantity greater than 0
/// 2. Adding an existing ingredient increases its current quantity
/// 3. Removing an ingredient removes it from the available ingredients

struct ManageAvailableIngredientsUseCase { /// Business logic: what should happen when a student adds/removes an ingredient
    enum IngredientError: LocalizedError, Equatable {
        case invalidQuantity
        case ingredientNotFound
        var errorDescription: String? {
            switch self {
            case .invalidQuantity:
                return "Ingredient quantity must be greater than 0. Enter a valid quantity."
            case .ingredientNotFound:
                return "This ingredient is not currently in your available ingredients."
            }
        }
    }
    let repository: IngredientRepository
    func add(_ ingredient: Ingredient) throws { /// Function to add ingredient
        guard ingredient.quantity > 0 else { /// Checks that quantity is greater than 0
            throw IngredientError.invalidQuantity
        }
        if let existingIngredient = repository.ingredients.first( /// Checks spelling of same ingredient for capitalisation
            where: { existingIngredient in existingIngredient.name.lowercased() == ingredient.name.lowercased() }
        ) {
            var updatedIngredient = existingIngredient /// If the ingredient exists, quantity must increase
            updatedIngredient.quantity += ingredient.quantity
            repository.update(updatedIngredient)
        } else { // If ingredient does not exist, add as new
            repository.add(ingredient)
        }
    }
    func remove(_ ingredient: Ingredient) throws { /// Function to remove ingredient
        guard repository.ingredients.contains( /// Checks if repositiory contains this ID
            where: { storedIngredient in storedIngredient.id == ingredient.id }
        ) else {
            throw IngredientError.ingredientNotFound
        }
        repository.delete(ingredient) /// If ingredient exists, repository removes it
    }
}
