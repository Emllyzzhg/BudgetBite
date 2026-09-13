//
//  BudgetBiteTests.swift
//  BudgetBiteTests
//
//  Created by emily zhang on 12/9/2026.
//

import Testing
import Foundation
@testable import BudgetBite

struct BudgetBiteTests {
    /// Tests that valid spending reduces the remaining budget
    @Test func validSpendingReducesBudget() {
        let useCase = UpdateFoodBudgetUseCase()
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 25.00
        )
        /// Attempts to update the budget with valid spending
        let updatedBudget = try? useCase.execute(
            budget: budget,
            spending: 10.00
        )
        /// Checks that $10 spending reduces the remaining budget to $15
        #expect(updatedBudget?.remainingBudget == 15.00)
    }
    
    /// Tests that negative spending is rejected
    @Test func negativeSpendingFails() {
        
        let useCase = UpdateFoodBudgetUseCase()
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 25.00
        )
        /// Checks that the use case throws an error for negative spending
        #expect(throws: UpdateFoodBudgetUseCase.UpdateFoodBudgetError.self) {
            try useCase.execute(
                budget: budget,
                spending: -5.00
            )
        }
    }
    
    /// Tests that spending greater than the remaining budget is rejected
    @Test func spendingExceedsRemainingBudgetFails() {
        let useCase = UpdateFoodBudgetUseCase()
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 25.00
        )
        /// Checks that the use case throws an error when spending is greater than the remaining budget
        #expect(throws: UpdateFoodBudgetUseCase.UpdateFoodBudgetError.self) {
            try useCase.execute(
                budget: budget,
                spending: 30.00
            )
        }
    }
    
    /// Tests that setting a new weekly budget updates the budget
    @Test func settingNewWeeklyBudgetUpdatesBudget() throws {
        
        let useCase = SetWeeklyBudgetUseCase()
        let currentBudget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 20.00
        )
        /// Updates the budget to a new weekly amount
        let updatedBudget = try useCase.execute(
            currentBudget: currentBudget,
            newWeeklyBudget: 40.00
        )
        /// Checks that both budget amounts have been updated to $40
        #expect(updatedBudget.weeklyBudget == 40.00)
        #expect(updatedBudget.remainingBudget == 40.00)
    }
    
    /// Tests that zero weekly budget is rejected
    @Test func settingZeroWeeklyBudgetFails() {
        let useCase = SetWeeklyBudgetUseCase()
        let currentBudget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 20.00
        )
        /// Checks that the use case throws an error when the new budget is zero
        #expect(throws: SetWeeklyBudgetUseCase.BudgetError.self) {
            try useCase.execute(
                currentBudget: currentBudget,
                newWeeklyBudget: 0
            )
        }
    }
    
    /// Tests that affordable meals are recommended
    @Test func affordableMealsAreRecommended() throws {
        let recipeRepository = LocalRecipeRepository()
        let ingredientRepository = LocalIngredientRepository()
        
        let useCase = GenerateMealRecommendationsUseCase(
            recipeRepository: recipeRepository,
            ingredientRepository: ingredientRepository
        )
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 5.00
        )
        /// Generates meal recommendations using the student's remaining budget
        let recommendations = try useCase.execute(
            budget: budget
        )
        /// Checks that recommendations are available and affordable
        #expect(!recommendations.isEmpty)
        #expect(recommendations.allSatisfy {
            $0.costToBuy <= budget.remainingBudget
        }
        )
    }
    
    /// Tests that unaffordable meals  are excluded
    @Test func unaffordableMealsAreExcluded() throws {
        let recipeRepository = LocalRecipeRepository()
        let ingredientRepository = LocalIngredientRepository()
        
        let useCase = GenerateMealRecommendationsUseCase(
            recipeRepository: recipeRepository,
            ingredientRepository: ingredientRepository
        )
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 5.00
        )
        /// Generates meal recommendations using the student's remaining budget
        let recommendations = try useCase.execute(
            budget: budget
        )
        /// Checks that all recommended meals cost $5 or less
        #expect(recommendations.allSatisfy {
            $0.costToBuy <= budget.remainingBudget
        }
        )
    }
    
    /// Tests that a new ingredient is added to the available ingredients
    @Test func addNewIngredientWorks() throws {
        let repository = LocalIngredientRepository()
        let useCase = ManageAvailableIngredientsUseCase(
            repository: repository
        )
        let ingredient = Ingredient(
            name: "Potato",
            quantity: 3
        )
        /// Stores the number of ingredients before adding the new ingredient
        let countBeforeAdd = repository.ingredients.count
        /// Adds the new ingredient to the repository
        try useCase.add(ingredient)
        /// Checks that the number of ingredients increased by one
        #expect(repository.ingredients.count == countBeforeAdd + 1)
    }
    
    /// Add the same ingredient again with a different quantity.
    @Test func addDuplicateIngredientWithDifferentQuantity() throws {
        let repository = LocalIngredientRepository()
        let useCase = ManageAvailableIngredientsUseCase(
            repository: repository
        )
        // Removes existing ingredients so the test starts with an empty repository.
        repository.ingredients.forEach {
            repository.delete($0)
        }
        let firstIngredient = Ingredient(
            name: "Rice",
            quantity: 2
        )
        /// Adds the first Rice ingredient with a quantity of 2
        try useCase.add(firstIngredient)
        let secondIngredient = Ingredient(
            name: "Rice",
            quantity: 3
        )
        /// Adds Rice again with a quantity of 3
        try useCase.add(secondIngredient)
        let rice = repository.ingredients.first {
            $0.name == "Rice"
        }
        /// Checks that the Rice quantity has increased to 5
        #expect(rice?.quantity == 5)
    }
        
    /// Tests that an ingredient with zero quantity is rejected.
    @Test func zeroQuantityIngredientFails() {
        let repository = LocalIngredientRepository()
        let useCase = ManageAvailableIngredientsUseCase(
            repository: repository
        )
        let ingredient = Ingredient(
            name: "Potato",
            quantity: 0
        )
        /// Checks that the use case throws an error when the quantity is zero
        #expect(throws: ManageAvailableIngredientsUseCase.IngredientError.self) {
            try useCase.add(ingredient)
        }
    }
    /// Tests that valid restoration increases remaining budget
    @Test func restoringFoodBudgetIncreasesRemainingBudget() throws {
        let useCase = RestoreFoodBudgetUseCase()
        
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 35.00
        )
        
        let updatedBudget = try useCase.execute(
            budget: budget,
            amount: 5.00
        )
        /// Checks that the use case actually increases the remaining budget
        #expect(updatedBudget.remainingBudget == 40.00)
    }
    
    /// Tests that restoration that would exceed the weekly budget fails
    @Test func negativeRestoreAmountFails() {
        let useCase = RestoreFoodBudgetUseCase()
        
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 35.00
        )
        /// Checks that the restore amount cannot be negative
        #expect(throws: RestoreFoodBudgetUseCase.RestoreFoodBudgetError.self) {
            try useCase.execute(
                budget: budget,
                amount: -15.00
            )
        }
    }
    /// Tests that negative restoration fails
    @Test
    func restoringBeyondWeeklyBudgetFails() {
        let useCase = RestoreFoodBudgetUseCase()
        let budget = Budget(
            weeklyBudget: 50.00,
            remainingBudget: 45.00
        )
        #expect(throws: RestoreFoodBudgetUseCase.RestoreFoodBudgetError.self) {
            try useCase.execute(
                budget: budget,
                amount: 10.00
            )
        }
    }
}

