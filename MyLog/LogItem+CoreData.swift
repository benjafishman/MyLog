//
//  LogItem+CoreData.swift
//  MyLog
//
//  Created by Ben Fishman on 7/19/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import Foundation

extension LogItem {
    
    func addLogItem2(item:LogItem2) {
        
        self.mutableSetValueForKey("logitem2").addObject(item)
    }
    
}
