//
//  IngredientsView.swift
//  BudgetBite
//
//  Created by emily zhang on 9/9/2026.
//

import SwiftUI

/// This view is responsible for displaying and managing the student's ingredients

/// Defines IngredientsView as a SwiftUI view
struct IngredientsView: View {
    
    /// Gets access to the IngredientViewModel so it can provide the ingredient data and functions needed to manage them
    @EnvironmentObject private var ingredientViewModel: IngredientViewModel
    
    /// Defines user interface displayed by this view
    var body: some View {
        /// Creates a navigation container for the view
        NavigationStack {
            /// Creates a list that displays the ingredients in a vertically scrollable format
            List {
                /// Goes through the ingredients stored in ingredientViewModel.ingredients. Each ingredient is displayed as an individual row in the list
                ForEach(ingredientViewModel.ingredients) { ingredient in HStack {
                        Text(ingredient.name)
                        Spacer()
                        Text("Qty: \(ingredient.quantity)")
                            .foregroundStyle(.secondary)
                    }
                }
                /// Adds swipe-to-delete functionality to the ingredient list. It identifies the position of the ingredient that the student wants to delete
                .onDelete { indexSet in
                    /// Goes through the indexes of the ingredients selected for deletion
                    for index in indexSet {
                        let ingredient =
                            ingredientViewModel.ingredients[index]
                        /// Calls the delete function from IngredientViewModel to remove the selected ingredient
                        ingredientViewModel.delete(ingredient)
                    }
                }
            }
            /// Title displayed at the top of the navigation screen is "My Ingredients"
            .navigationTitle("My Ingredients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        /// Calls the add function from IngredientViewModel to add a new ingredient to the student's ingredient list
                        /// Adds a new ingredient with the name "Potato" and a quantity of 1
                        ingredientViewModel.add(
                            Ingredient(
                                name: "Potato",
                                quantity: 1
                            )
                        )
                    }
                }
            }
        }
    }
}
 
#Preview {
    IngredientsView()
}
