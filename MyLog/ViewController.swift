//
//  ViewController.swift
//  MyLog
//
//  Created by Ben Fishman on 7/14/15.
//  Copyright (c) 2015 Ben Fishman. All rights reserved.
//

import UIKit

import CoreData

class CustomTableViewCell : UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBAction func addLogItem(sender: AnyObject) {
        
        println("pressed log button")
        
        println(AnyObject)
        
        
    }
    
    func loadItem(title: String) {
        titleLabel.text = title + " YOOOO"
    }
    

}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var logItems = [LogItem]()
    
    private var passedLogItem : LogItem?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell1")
        
        println(logItems.count)
        
        /*
        
        if logItems.count <= 0 {
        
            if let moc = self.managedObjectContext {
                var items = [
                    ("Best Animal", "Dog"),
                    ("Best Language","Swift"),
                    ("Worst Animal","Cthulu"),
                    ("Worst Language","LOLCODE")
                ]
                
                for (itemTitle, itemText) in items {
                    LogItem.createInManagedObjectContext(moc,title:itemTitle, text: itemText)
                }
            }
        }
*/
        
        fetchLog()
        
        //print(managedObjectContext)
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "LogItem")
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [LogItem] {
            logItems = fetchResults
        }
    }

    
    /*
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest(entityName: "LogItem")
        
        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [LogItem] {
            
    
            // Create an Alert, and set it's message to whatever the itemText is
            let alert = UIAlertController(title: fetchResults[0].title,
                message: fetchResults[0].itemText,
                preferredStyle: .Alert)
            
            // Display the alert
            self.presentViewController(alert,
                animated: true,
                completion: nil)
        }
    }*/
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        
        println("add")
        var titlePrompt = UIAlertController(title: "Enter Title",
            message: "Enter Text",
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Title"
        }

        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.saveNewItem(textField.text)
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func saveNewItem(title : String) {
        // Create the new  log item
        var newLogItem = LogItem.createInManagedObjectContext(self.managedObjectContext!, title: title, text: "")
        
        /*
         * Doin some fake jazz to preload logItem2, i.e. not production worthy code
         */
        for var i = 0; i < 3; i++
        {
            println("here \(i)")
            var newTitle = title + " \(i)"
            
            var newLogItem2 = LogItem2.createInManagedObjectContext(self.managedObjectContext!, textItem: newTitle, logItem: newLogItem)
            
            newLogItem.addLogItem2(newLogItem2)
            
            //newLogItem2.logitem = newLogItem
        }
        
        
        
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(logItems, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            tableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }

        /* UITableView function */
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return logItems.count
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
            
            var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell1") as CustomTableViewCell
            
            let logItem = logItems[indexPath.row]
        
            
            cell.loadItem(logItem.title)
        
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let logItem = logItems[indexPath.row]
        
        println(logItem.getTitle())
        println("CLICKED CELL")
        
        passedLogItem = logItem
        
        println(passedLogItem?.getTitle())
        
        self.performSegueWithIdentifier("logItem2", sender: self)

        /*
        let logItem2ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LogItem2ViewController") as LogItem2ViewController
        
        self.navigationController?.pushViewController(logItem2ViewController, animated: true)
        */
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let vc = segue.destinationViewController as? LogItem2ViewController {
            
                vc.passedLogItem = passedLogItem!
            
        }
        
        
    }



}

