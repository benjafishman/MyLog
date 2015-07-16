//
//  LogItem2.swift
//  MyLog
//
//  Created by Ben Fishman on 7/14/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import Foundation
import CoreData

class LogItem2: NSManagedObject {

    @NSManaged var textItem: String
    @NSManaged var number: NSNumber
    @NSManaged var logitem: MyLog.LogItem
    
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, textItem: String, logItem: MyLog.LogItem) -> LogItem2 {
        
        let newLogItem2 = NSEntityDescription.insertNewObjectForEntityForName("LogItem2", inManagedObjectContext: moc) as LogItem2
        
        newLogItem2.logitem = logItem
        
        newLogItem2.textItem = textItem + " - test!"
        
        newLogItem2.number = 1
        
        return newLogItem2
    }
    
    func getTextItem() -> String {
        return textItem
    }
    
}
