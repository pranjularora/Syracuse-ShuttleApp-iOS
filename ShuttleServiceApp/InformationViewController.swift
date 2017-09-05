//
//  InformationViewController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/30/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class InformationViewController: UIViewController{
    
    //IBOutlets Textfields declared
    @IBOutlet var name_textf: UITextField!
    @IBOutlet var suid_textf: UITextField!
    @IBOutlet var address_textf: UITextField!
    @IBOutlet var time_textf: UITextField!

    /*
        Variables defined below are used by the previous view control to pass values through the segue that was performed
    */
    var name:String!
    var address:String!
    var suid:String!
    var time:String!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //adding values to text fields
        
        name_textf.text = name
        suid_textf.text = suid
        address_textf.text = address
        time_textf.text = time
    }
}
