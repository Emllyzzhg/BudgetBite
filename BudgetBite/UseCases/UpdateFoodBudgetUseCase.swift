//
//  UpdateFoodBudgetUseCase.swift
//  BudgetBite
//
//  Created by emily zhang on 3/9/2026.
//

import Foundation
 
/// Use Case 1: updates a university student's remaining food budget after spending. Receives the current budget and spending amount, and apply the budget business rules
///
/// Business rules:
/// 1. Spending cannot be less than $0 or a negative number
/// 2. Spending cannot be greater than the student's remaining budget
/// 3. The remaining budget is reduced by the amount spent

struct UpdateFoodBudgetUseCase { // Business logic: what should happen to the food budget after spending occurs
    enum UpdateFoodBudgetError: LocalizedError, Equatable {
        case negativeSpending
        case spendingExceedsRemainingBudget
        var errorDescription: String? {
            switch self {
            case .negativeSpending:
                return "The spending amount cannot be negative. Please enter a valid amount."
            case .spendingExceedsRemainingBudget:
                return "This purchase is greater than your remaining food budget. Please enter a smaller amount."
            }
        }
    }
    func execute( /// Function that performs the update where it takes current budget and previous budget, and returns updated Budget
        budget: Budget,
        spending: Double
    ) throws -> Budget {
        guard spending >= 0 else { /// Checks that spending is not less than $0
            throw UpdateFoodBudgetError.negativeSpending
        }
        guard spending <= budget.remainingBudget else { ///Check that spending is not greater than the budget
            throw UpdateFoodBudgetError.spendingExceedsRemainingBudget
        }
        var updatedBudget = budget
        updatedBudget.remainingBudget -= spending /// The remaining budget is reduced by the amount spent
        return updatedBudget
    }
}
