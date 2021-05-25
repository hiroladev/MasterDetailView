//
//  NavigationItemsLoader.swift
//  MasterDetailView
//
//  Created by mis on 24.05.21.
//

import Foundation

internal struct NavigationItemsLoader {
    
    internal static func loadNavigationItems() throws -> [NavigationItem] {
        
        //  list of navigation items
        var navigationItems: [NavigationItem] = []
    
        do {
            
            guard let bundlePath = Bundle.main.path(forResource: "NavigationItems", ofType: "json") else {
                
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "JSON not found."])
                
            }
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                let decoder = JSONDecoder()
                navigationItems = try decoder.decode([NavigationItem].self, from: jsonData)
                
            } else {
                
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can't load items."])
                
            }

            
        } catch (let error) {
            
            throw error
            
        }
        
        return navigationItems
        
    }
    
}
