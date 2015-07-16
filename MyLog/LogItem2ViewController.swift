//
//  LogItem2ViewController.swift
//  MyLog
//
//  Created by Ben Fishman on 7/15/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import UIKit

import CoreData

class LogItem2ViewController: UIViewController {
    
    private var logItem: LogItem!
    
    @IBOutlet weak var label: UILabel!
    
    var passedLogItem : LogItem?
    
    var logItems2 = [LogItem2]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        logItem = passedLogItem
        
        println(logItem?.title)
        
        label.text = logItem?.getTitle()
        
        fetchLog()
        
        println("HERE")
        
        var logItem2 = logItems2[0]
        
        println(logItem2.getTextItem())
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchLog() {
        
        let fetchRequest = NSFetchRequest(entityName: "LogItem2")
        
        fetchRequest.predicate = NSPredicate(format:"logitem == %@ ", logItem)
        
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        let sortDescriptor = NSSortDescriptor(key: "textItem", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [LogItem2] {
         
            logItems2 = fetchResults
        } else {
            println("FAILED")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
