//
//  DataController.swift
//  colormind-test
//
//  Created by Rudolf Paduraru on 02/08/2020.
//  Copyright © 2020 Rudolf Paduraru. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    static var colorArray = [SavedColor]()
    
    
    
    let container: NSPersistentContainer
      
    init(modelName : String) {
        container = NSPersistentContainer(name: modelName)
    }
       
    var viewContext : NSManagedObjectContext{
        return container.viewContext
    }
    
    func saveItems() {
        do {
          try viewContext.save()
        } catch {
           print("Error saving context \(error)")
        }
        
    }


     func loadItems(with request: NSFetchRequest<SavedColor> = SavedColor.fetchRequest(), predicate: NSPredicate? = nil) {
        
        
           do {
            DataController.colorArray = try viewContext.fetch(request)
           } catch {
               print("Error fetching data from context \(error)")
           }
                    
       }
}
