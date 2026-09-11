//
//  IngredientViewModel.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
import Combine

/// Manages the ingredients data displayed by the SwiftUI view
/// IngredientViewModel communicates with ManageAvailableIngredientsUseCase to add and remove ingredients and loads current ingredients from ingredient repository

final class IngredientViewModel: ObservableObject {
    /// The current list of available ingredients
    @Published var ingredients: [Ingredient] = []
    /// Stores an error message to display to the student.
    @Published var errorMessage: String?
    
    /// Stores the IngredientRepository and ManageAvailableUseCase to be used by this view model
    private let repository: IngredientRepository
    private let manageIngredientsUseCase: ManageAvailableIngredientsUseCase

    /// Creates the ViewModel with the ingredient repository and the ManageAvailableIngredientsUseCase, then loads the current ingredients
    init(repository: IngredientRepository) {
        self.repository = repository
        self.manageIngredientsUseCase = ManageAvailableIngredientsUseCase(
                repository: repository
            )
        load()
    }
    /// Function to load the current ingredients from the repository
    func load() {
        ingredients = repository.ingredients
    }
    /// Function to add an ingredient using the use case and reloads the ingredient list
    func add(_ ingredient: Ingredient) {
        do {
            try manageIngredientsUseCase.add(ingredient)
            /// Clears any previous error after a successful operation.
            errorMessage = nil
            load()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    /// Function to delete an ingredient from the available ingredients and reloads the ingredient list
    func delete(_ ingredient: Ingredient) {
        do {
            try manageIngredientsUseCase.remove(ingredient)
            /// Clears any previous error after a successful operation.
            errorMessage = nil
            load()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
