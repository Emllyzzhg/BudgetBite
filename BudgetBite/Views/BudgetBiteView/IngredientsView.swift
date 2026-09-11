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
    
    @State private var showingAddIngredient = false
    @State private var ingredientName = ""
    @State private var ingredientQuantity = "1"
    
    /// Defines user interface displayed by this view
    var body: some View {
        /// Creates a navigation container for the view
        NavigationStack {
            /// Creates a list that displays the ingredients in a vertical format
            List {
                /// Displays a message when there are no ingredients
                if ingredientViewModel.ingredients.isEmpty {
                    ContentUnavailableView(
                        "You have no ingredients",
                        systemImage: "refrigerator",
                        description: Text( "Add ingredients you currently have available.")
                    )
                } else {
                    /// Displays each ingredient in the student's list
                    ForEach(ingredientViewModel.ingredients) { ingredient in
                        HStack {
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
                            let ingredient = ingredientViewModel.ingredients[index]
                            /// Calls the delete function from IngredientViewModel to remove the selected ingredient
                            ingredientViewModel.delete(ingredient)
                        }
                    }
                }
            }
            /// Title displayed at the top of the navigation screen is "My Ingredients"
            .navigationTitle("My Ingredients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        /// Clears the previous error message
                        ingredientViewModel.errorMessage = nil
                        /// Clears the input fields before displaying the add ingredient form
                        ingredientName = ""
                        ingredientQuantity = "1"
                        showingAddIngredient = true
                    }
                }
            }
            /// Displays the Add Ingredient form when showingAddIngredient is true
            .sheet(isPresented: $showingAddIngredient) {
                NavigationStack {
                    Form {
                        Section("Ingredient"){
                            TextField("Ingredient name", text: $ingredientName)
                            TextField("Quantity", text: $ingredientQuantity)
                                .keyboardType(.numberPad)
                        }
                        /// Displays the error message if adding the ingredient fails
                        if let errorMessage = ingredientViewModel.errorMessage {
                            Section {Text(errorMessage)
                                    .font(.footnote)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        Section {
                            Button("Add Ingredient") {
                                /// Checks that the quantity entered is a valid number
                                if let quantity = Int(ingredientQuantity),
                                   !ingredientName.trimmingCharacters(in: .whitespaces).isEmpty {
                                    /// Creates new ingredient using the ViewModel
                                    let ingredient = Ingredient(
                                        name: ingredientName,
                                        quantity: quantity
                                    )
                                    /// Adds the new ingredient using the ViewModel
                                    ingredientViewModel.add(ingredient)
                                    
                                    /// Closes the form only if adding the ingredient was successful
                                    if ingredientViewModel.errorMessage == nil {
                                        showingAddIngredient = false
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Add Ingredient")
                    .toolbar {
                        /// Adds a Cancel button
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingAddIngredient = false
                            }
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    IngredientsView()
}
