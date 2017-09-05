//
//  DriverPageController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/28/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit

class DriverPageController: UITableViewController {
   
    var noofRowsInSection: [Int] = [1]
    //var itemStore =  ItemStore()
    var regItemStore =  RegisteredItemStore() //creates an instance of registeredItemStore
    
    override func viewDidLoad() {
        super.viewDidLoad()     
    }
    
    //Returns number of sections in table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return RegisterItem.sectionBasedOntime.count
        return 1
    }
    
    //Returns number of rows in sections
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      //  return noofRowsInSection[section]
        return  regItemStore.allRegisteredItems.count + 2
    }
    
    //Function called when segue is initiated
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        let vc = segue.destinationViewController as! InformationViewController //instantiating destination view controller
        
        if (segue.identifier == "NavigateToInfo")
        {   //Checking for segue identifier
            
            if let row = tableView.indexPathForSelectedRow?.row
            {   //transferring name,suid,address and time to destination view controller
                let item = regItemStore.allRegisteredItems[row-2]
                let selectedSuid = item.suid
                let selectedTime = item.time
                vc.suid = String(selectedSuid)
                vc.time = selectedTime
                var indexCount = -1
                for regItem in regItemStore.allRegisteredItems
                {
                    indexCount = indexCount + 1
                    if(selectedSuid == regItem.suid)
                    {
                        if(regItem.time == selectedTime)
                        {
                            vc.name = regItem.name
                            vc.address = regItem.address
                            break
                        }
                    }
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("indexpathrow: \(indexPath.row)")
        if indexPath.row == 0
        {   //For first defualt row
            let hc = tableView.dequeueReusableCellWithIdentifier("HeadingCell", forIndexPath: indexPath) as! HeadingCell
            hc.headingLabel.text = "Registrations"
            return hc
        }
            
        else if indexPath.row == 1
        {   //For second default row
            let hc = tableView.dequeueReusableCellWithIdentifier("ItemHeadingCell", forIndexPath: indexPath) as! HeadingCell
            hc.suid_heading.text = "SUID"
            hc.time_heading.text = "TIME"
            hc.suid_heading.font = UIFont.boldSystemFontOfSize(16)
            hc.time_heading.font = UIFont.boldSystemFontOfSize(16)
            return hc
        }
        
        //Adds rows to table view
        let contentCell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        contentCell.suid.text = String(regItemStore.allRegisteredItems[indexPath.row - 2].suid)
        contentCell.time.text = regItemStore.allRegisteredItems[indexPath.row - 2].time
        return contentCell
    }

}
