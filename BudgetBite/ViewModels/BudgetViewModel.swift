//
//  BudgetViewModel.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
import Combine

/// Manages the budget data displayed by the SwiftUI view and communicates with UpdateFoodBudgetUseCase i.e., what happens when the user interacts with the view

final class BudgetViewModel: ObservableObject {
    @Published var budget: Budget
    private let updateBudgetUseCase: UpdateFoodBudgetUseCase // Stores the UpdateFoodBudgetUseCase, used internally by this ViewModel
    init( // Set up the ViewModel with the current budget and UpdateFoodBudgetUseCase
        budget: Budget,
        updateBudgetUseCase: UpdateFoodBudgetUseCase
    ) {
        self.budget = budget
        self.updateBudgetUseCase = updateBudgetUseCase
    }
    func updateBudget(spending: Double) { // Function to update budget using the current budget and spending amount
        do {
            budget = try updateBudgetUseCase.execute(
                budget: budget,
                spending: spending
            )
        } catch { // If UpdateFoodBudgetUseCase throws error, catch runs
            print(error.localizedDescription)
        }
    }
}
