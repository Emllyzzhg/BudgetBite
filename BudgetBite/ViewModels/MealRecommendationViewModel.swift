//
//  MealRecommendationViewModel.swift
//  BudgetBite
//
//  Created by emily zhang on 9/9/2026.
//

import Foundation
import Combine

/// Manages meal recommendations displayed by the SwiftUI view
/// MealRecommendationViewModel uses GenerateMealRecommendationsUseCase to generate recipe recommendations based on the user's budget
 
final class MealRecommendationViewModel: ObservableObject {
    /// The recipe recommendations generated for the current budget
    /// An error message displayed when generating recipe recommendations fails
    @Published var recommendations: [Recipe] = []
    @Published var errorMessage: String?
    /// Stores the GenerateMealRecommendationsUseCase to be used by this view model
    private let generateRecommendationsUseCase:
        GenerateMealRecommendationsUseCase
    
    /// Creates the ViewModel with GenerateMealRecommendationsUseCase
    init(
        generateRecommendationsUseCase:
            GenerateMealRecommendationsUseCase
    ) {
        self.generateRecommendationsUseCase =
            generateRecommendationsUseCase
    }
    /// Function to generate meal recommendations based on provided budget
    /// If generating recommendations fails, an error message is displayed
    func generateRecommendations(budget: Budget) {
        
        do {
            recommendations =
                try generateRecommendationsUseCase.execute(
                    budget: budget
                )
            
            errorMessage = nil
            
        } catch {
            recommendations = []
            errorMessage = error.localizedDescription
        }
    }
}
