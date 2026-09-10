//
//  MealPlanViewModel.swift
//  BudgetBite
//
//  Created by emily zhang on 9/9/2026.
//

import Foundation
import Combine
 
/// Manages the meals planned for a meal plan
/// MealPlanViewModel stores the current collection of planned meals and publishes changes so SwiftUI views can react to updates

final class MealPlanViewModel: ObservableObject {
    /// The current list of meals in meal plan
    @Published var plannedMeals: [MealPlanEntry] = []
    /// Function to add a meal to the meal plan
    func add(_ meal: MealPlanEntry) {
        plannedMeals.append(meal)
    }
    /// Function to delete a meal from the meal plan
    func delete(_ meal: MealPlanEntry) {
        plannedMeals.removeAll { $0.id == meal.id }
    }
}
