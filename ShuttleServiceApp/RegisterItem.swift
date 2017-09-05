//
//  RegisterItem.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/28/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class RegisterItem:NSObject,NSCoding{
    
    //Attributes that are required to register a student
     var name: String
     var suid: Int
     var time: String
     var address: String
    let itemKey: String
    
    init(name:String,suid:Int,time:String,address:String)
    {
        self.name = name
        self.suid = suid
        self.time = time
        self.address = address
        self.itemKey = NSUUID().UUIDString //Unique item id that is used to save values to files
        
        super.init()
    }
    
    //encodeWithCoder() encodes an intance of "Item" inside the NSCoder instance that is passed in the argument
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(address, forKey: "address")
        aCoder.encodeInteger(suid, forKey: "suid")
        aCoder.encodeObject(itemKey,forKey: "itemKey")
        
    }
    //init() returns an object initialized from data in the NSCoder instance that is passed in the argument
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        address = aDecoder.decodeObjectForKey("address") as! String
        time = aDecoder.decodeObjectForKey("time") as! String
        suid = aDecoder.decodeIntegerForKey("suid")
        itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        
        super.init()
    }
}
