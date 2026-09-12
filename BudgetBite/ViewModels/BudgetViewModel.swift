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
    /// Stores the UpdateFoodBudgetUseCase and SetWeeklyBudgetUseCase to be used by this view model
    private let updateBudgetUseCase: UpdateFoodBudgetUseCase
    private let restoreFoodBudgetUseCase: RestoreFoodBudgetUseCase
    private let setWeeklyBudgetUseCase: SetWeeklyBudgetUseCase
    
    /// Create the ViewModel with the current budget, UpdateFoodBudgetUseCase, RestoreFoodBudgetUseCase and SetWeeklyBudgetUseCase
    init(
        budget: Budget,
        updateBudgetUseCase: UpdateFoodBudgetUseCase,
        restoreFoodBudgetUseCase: RestoreFoodBudgetUseCase,
        setWeeklyBudgetUseCase: SetWeeklyBudgetUseCase
    ) {
        self.budget = budget
        self.updateBudgetUseCase = updateBudgetUseCase
        self.restoreFoodBudgetUseCase = restoreFoodBudgetUseCase
        self.setWeeklyBudgetUseCase = setWeeklyBudgetUseCase
    }
    /// Function to update budget using the current budget and spending amount
    func updateBudget(spending: Double) -> Bool {
        do {
            budget = try updateBudgetUseCase.execute(
                budget: budget,
                spending: spending
            )
            errorMessage = nil
            return true
        } catch { /// If UpdateFoodBudgetUseCase throws error, catch runs
            errorMessage = error.localizedDescription
            return false
        }
    }
    /// Function to update the weekly budget with the newly entered amount
    func setWeeklyBudget(_ newWeeklyBudget: Double) {
        do {budget = try setWeeklyBudgetUseCase.execute(
            currentBudget: budget, newWeeklyBudget: newWeeklyBudget
            )
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    func restoreBudget(amount: Double) -> Bool {
        do {
            budget = try restoreFoodBudgetUseCase.execute(
                budget: budget,
                amount: amount
            )
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
