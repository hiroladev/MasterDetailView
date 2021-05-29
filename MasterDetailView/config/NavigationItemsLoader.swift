/*

NavigationItemsLoader.swift
MasterDetailView
 
MIT License

Copyright (c) 2021 Michael Schmidt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 */

import Foundation

internal class NavigationItemsLoader {
    
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
