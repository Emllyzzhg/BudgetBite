//
//  BudgetViewModel.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
import Combine

/// Manages the budget data displayed by the SwiftUI view
/// BudgetViewModel communicates with UpdateFoodBudgetUseCase to update the budget when the user changes their spending

final class BudgetViewModel: ObservableObject {
    /// The current budget displayed by the SwiftUI view
    @Published var budget: Budget
    @Published var errorMessage: String?
    /// Stores the UpdateFoodBudgetUseCase to be used by this view model
    private let updateBudgetUseCase: UpdateFoodBudgetUseCase
    
    /// Create the ViewModel with the current budget and UpdateFoodBudgetUseCase
    init(
        budget: Budget,
        updateBudgetUseCase: UpdateFoodBudgetUseCase
    ) {
        self.budget = budget
        self.updateBudgetUseCase = updateBudgetUseCase
    }
    /// Function to update budget using the current budget and spending amount
    func updateBudget(spending: Double) {
        do {
            budget = try updateBudgetUseCase.execute(
                budget: budget,
                spending: spending
            )
            errorMessage = nil
        } catch { // If UpdateFoodBudgetUseCase throws error, catch runs
            errorMessage = error.localizedDescription
        }
    }
}
