//
//  NavigationItem.swift
//  MasterDetailView
//
//  Created by mis on 24.05.21.
//

import Foundation
import Cocoa

internal struct NavigationItem: Decodable {
    
    internal var title: String!
    
    internal var storyboardID: String!
    
    init(title: String, storyboardID: String) {
        
        self.title = title
        self.storyboardID = storyboardID
        
    }
    
}
