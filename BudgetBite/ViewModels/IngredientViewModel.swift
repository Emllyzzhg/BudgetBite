//
//  IngredientViewModel.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
import Combine

/// Manages the ingredients data displayed by the SwiftUI view and communicates with ManageAvailableIngredientsUseCase i.e., what happens when the user interacts with the view

final class IngredientViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    private let repository: IngredientRepository // Stores the IngredientRepository and ManageAvailableUseCase used internally by this ViewModel
    private let manageIngredientsUseCase: ManageAvailableIngredientsUseCase

    init(repository: IngredientRepository) { // Set up the ViewModel with the ingredient repository, create the ManageAvailableIngredientsUseCase and load the current ingredients
        self.repository = repository
        self.manageIngredientsUseCase = ManageAvailableIngredientsUseCase(
                repository: repository
            )
        load()
    }
    func load() { // Function to load the current ingredients from the repository
        ingredients = repository.ingredients
    }
    func add(_ ingredient: Ingredient) { // Function to add an ingredient using the use case and reloads the ingredient list
        do {
            try manageIngredientsUseCase.add(ingredient)
            load()
        } catch {
            print(error.localizedDescription)
        }
    }
    func delete(_ ingredient: Ingredient) { // Function to delete an ingredient using the use case and reloads the ingredient list
        do {
            try manageIngredientsUseCase.remove(ingredient)
            load()
        } catch {
            print(error.localizedDescription)
        }
    }
}
