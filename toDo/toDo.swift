//
//  toDo.swift
//  toDo
//
//  Created by Philip Taylor on 3/5/20.
//  Copyright © 2020 Philip Taylor. All rights reserved.
//

import Foundation

class toDoItem {
    
    var title: String
    var done: Bool
    
    public init (title: String) {
        
        self.title = title
        self.done = false
        
    }
    
}

extension toDoItem {
    
    public class func getMockData() -> [toDoItem]
    {
        return [
            toDoItem(title: "Clean"),
            toDoItem(title: "Laundry"),
            toDoItem(title: "Shop"),
            toDoItem(title: "Errands")
        ]
    }
    
}
