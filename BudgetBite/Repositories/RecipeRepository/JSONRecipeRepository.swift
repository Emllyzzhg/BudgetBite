//
//  JSONRecipeRepository.swift
//  BudgetBite
//
//  Created by emily zhang on 31/8/2026.
//

import Foundation

class JSONRecipeRepository: RecipeRepository {
    private(set) var recipes: [Recipe] = []
    
    private let fileURL: URL
    
    init() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        fileURL = documentsURL.appendingPathComponent("Recipes.json")
        
        // Copy the bundled JSON to Documents the first time
        if !fileManager.fileExists(atPath: fileURL.path) {
            if let bundledURL = Bundle.main.url(
                forResource: "Recipes",
                withExtension: "json"
            ){
                try? fileManager.copyItem(
                    at: bundledURL,
                    to: fileURL
                )
            }
        }
        recipes = load()
    }
    
    func load() -> [Recipe] {
        do {
            let data = try Data(contentsOf: fileURL)
            
            return try JSONDecoder().decode(
                [Recipe].self,
                from: data
            )
        } catch {
            print("Failed to load recipes: \(error)")
            return []
        }
    }
    
    func add(_ recipe: Recipe) {
        recipes.append(recipe)
        save()
    }
    
    func update(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
            save()
        }
    }
    
    func delete(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(recipes)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save recipes: \(error)")
        }
    }
}
