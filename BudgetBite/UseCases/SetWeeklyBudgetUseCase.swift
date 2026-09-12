//
//  SetWeeklyBudgetUseCase.swift
//  BudgetBite
//
//  Created by emily zhang on 10/9/2026.
//

import Foundation
/// Use Case 4: sets a university student's weekly food budget 
///
/// Business rules:
/// 1. The weekly budget must be greater than zero
/// 2 Setting a new weekly budget resets the remaining budget to the new weekly budget amount

struct SetWeeklyBudgetUseCase { /// Business logic: what should happen if the student starts/restarts their weekly budget
    
    enum BudgetError: LocalizedError, Equatable {
        case invalidBudgetAmount
        var errorDescription: String? {
            switch self {
            case .invalidBudgetAmount:
                return "Your weekly food budget must be greater than $0. Enter a valid amount."
            }
        }
    }
    
    func execute( /// Function that executes set weekly budget operation, using current budget and new amount and returns updated budget 
        currentBudget: Budget,
        newWeeklyBudget: Double
    ) throws -> Budget {
        guard newWeeklyBudget > 0 else { /// Checks weekly budget is greater than zero
            throw BudgetError.invalidBudgetAmount
        }
        var updatedBudget = currentBudget
        updatedBudget.weeklyBudget = newWeeklyBudget /// Setting new budget resets old budget 
        updatedBudget.remainingBudget = newWeeklyBudget
        return updatedBudget
    }
}
 
