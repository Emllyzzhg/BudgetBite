//
//  JSONIngredientRepository.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import Foundation

class JSONIngredientRepository: IngredientRepository {
    private(set) var ingredients: [Ingredient] = []
    
    private let fileURL: URL
    
    init() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        fileURL = documentsURL.appendingPathComponent("Ingredients.json")
        
        // Copy the bundled JSON to Documents the first time
        if !fileManager.fileExists(atPath: fileURL.path) {
            if let bundledURL = Bundle.main.url(
                forResource: "Ingredients",
                withExtension: "json"
            ){
                try? fileManager.copyItem(
                    at: bundledURL,
                    to: fileURL
                )
            }
        }
        ingredients = load()
    }
    
    func load() -> [Ingredient] {
        do {
            let data = try Data(contentsOf: fileURL)
            
            return try JSONDecoder().decode(
                [Ingredient].self,
                from: data
            )
        } catch {
            print("Failed to load ingredients: \(error)")
            return []
        }
    }
    
    func add(_ ingredient: Ingredient) {
        ingredient.append(ingredient)
        save()
    }
    
    func update(_ ingredient: Ingredient) {
        if let index = ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            ingredients[index] = ingredient
            save()
        }
    }
    
    func delete(_ ingredient: Ingredient) {
        ingredients.removeAll { $0.id == ingredient.id }
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(ingredients)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save ingredients: \(error)")
        }
    }
}
