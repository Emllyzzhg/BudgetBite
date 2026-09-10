//
//  IngredientsView.swift
//  BudgetBite
//
//  Created by emily zhang on 9/9/2026.
//

import SwiftUI
 
struct IngredientsView: View {
    
    @EnvironmentObject private var ingredientViewModel: IngredientViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ingredientViewModel.ingredients) { ingredient in HStack {
                        Text(ingredient.name)
                        
                        Spacer()
                        
                        Text("Qty: \(ingredient.quantity)")
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete { indexSet in
                    
                    for index in indexSet {
                        let ingredient =
                            ingredientViewModel.ingredients[index]
                        
                        ingredientViewModel.delete(ingredient)
                    }
                }
            }
            .navigationTitle("My Ingredients")
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") {
                        
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
 
