//
//  RestoreFoodBudgetUseCase.swift
//  BudgetBite
//
//  Created by emily zhang on 12/9/2026.
//

import Foundation

/// Use Case 5: restores money to a student's remaining food budget when a planned meal is removed
///
/// Business rules:
/// 1. The amount restored cannot be negative
/// 2. The remaining budget cannot be greater than the weekly budget
/// 3. The restored amount is added to the remaining budget

struct RestoreFoodBudgetUseCase { /// Business logic: what should happen to the food budget after deleting a recommended meal occurs
    enum RestoreFoodBudgetError: LocalizedError, Equatable {
        case negativeRestoreAmount
        
        var errorDescription: String? {
            switch self {
            case .negativeRestoreAmount:
                return "The amount to restore cannot be negative. Please enter a valid amount."
            }
        }
    }
    
    func execute(
        budget: Budget,
        amount: Double
    ) throws -> Budget {
        guard amount >= 0 else {
            throw RestoreFoodBudgetError.negativeRestoreAmount
        }
        
        var updatedBudget = budget
        updatedBudget.remainingBudget += amount
        
        return updatedBudget
    }
}
