//
//  LogItem2ViewController.swift
//  MyLog
//
//  Created by Ben Fishman on 7/15/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import UIKit

import CoreData

class LogItem2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var logItem: LogItem!
    
    @IBOutlet weak var label: UILabel!
    
    var passedLogItem : LogItem?
    
    var logItems2 = [LogItem2]()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "LogItems2 View"
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        logItem = passedLogItem
        
        println(logItem?.title)
        
       // label.text = logItem?.getTitle()
        
        println("count nsset \(logItem.logitem2.count)")
        
        //fetchLog()
        /*
        if li2 = logItem.logitem2.allObjects as? LogItem2{
            println(li2)
        }
*/
       // var i = 0
        
        println( "TypeName0 = \(_stdlib_getDemangledTypeName(logItems2))")
        
        for object in logItem.logitem2.allObjects {
            
            let o = object as LogItem2
            println("\(o.getTextItem())")
            logItems2.append(o)
            //i++
        }
        
        println("HERE")
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
    
    
    /* UITableView function */
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return logItems2.count
    }
    
    /*
    
    func tableView(tableView: UITableView,
    heightForRowAtIndexPath
    indexPath: NSIndexPath) -> Int {
    return 107
    }
    */
    
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell
            
            cell.textLabel!.text = logItems2[indexPath.row].getTextItem()
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        println("CLICKED CELL")
    
    }
    
    /*
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let logItemToDelete = logItems[indexPath.row]
            
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(logItemToDelete)
            
            // Refresh the table view to indicate that it's deleted
            self.fetchLog()
            
            // Tell the table view to animate out that row
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            save()
        }
    }
*/


}
