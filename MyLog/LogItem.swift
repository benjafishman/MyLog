//
//  LogItem.swift
//  MyLog
//
//  Created by Ben Fishman on 7/14/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import Foundation
import CoreData

class LogItem: NSManagedObject {

    @NSManaged var itemText: String
    @NSManaged var title: String
    @NSManaged var logItem2: NSSet
    
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title: String, text: String) -> LogItem {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("LogItem", inManagedObjectContext: moc) as LogItem
        
        newItem.title = title
        
        newItem.itemText = text
        
        return newItem
    }
    
    func getTitle() -> String {
        return title
    }

}
