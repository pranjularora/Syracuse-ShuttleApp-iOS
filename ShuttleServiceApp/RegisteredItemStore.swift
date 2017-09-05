//
//  RegisteredItemStore.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 12/4/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class RegisteredItemStore{
    
    //Lits of all Registered items
    var allRegisteredItems = [RegisterItem]()
    
    //function that adds item to list
    func addItem(item: RegisterItem)
    {
        allRegisteredItems.append(item)
    } 
    
    //itemArchiveURL is the URL of the archive where we will save the allItems array
    let itemArchiveURL: NSURL = {_ in
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("items.archive")
    }()
    
    //saveChanges() archives the allItems array to the specified file
    func saveChanges() -> Bool {
        
        print("Saving items to: \(itemArchiveURL.path!)")
        
        //archiveRootObject() creates an instance of NSKeyedArchiver (which is a sub-class of NSCoder)
        //and calls encodeWithCoder() on the root object (the allItems array)
        //and subsequently encodeWithCoder() on all of its sub-objects RECURSIVELY
        //to save all the items inside the same instance of the NSKeyedArchiver
        return NSKeyedArchiver.archiveRootObject(allRegisteredItems, toFile: itemArchiveURL.path!)
    }
    
    //creates the allItems array from the data saved in the archive
    init() {
        //NSKeyedUnarchiver returns an Anyobject? initialized from data in the archive, which we downcast to [Item] (since the archive actually stores an [Item] object)
        print("Save Location: \(itemArchiveURL.path!)")
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [RegisterItem] {
            allRegisteredItems += archivedItems
        }
    }
}
