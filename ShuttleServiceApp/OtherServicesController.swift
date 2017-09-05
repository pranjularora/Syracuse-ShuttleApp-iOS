//
//  OtherServicesViewController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/26/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class OtherServicesController : UIViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    //function that makes a call by refering to the tel url
    @IBAction func CallDPS(sender: AnyObject) {       
        if let phoneURL = NSURL(string: "tel://9147338184")
        {
            UIApplication.sharedApplication().openURL(phoneURL)
        }
    }
    
    //function that makes a call by refering to the tel url
    @IBAction func CallMedicalServices(sender: AnyObject) {
        if let phoneURL = NSURL(string: "tel://3159499061")
        {
            UIApplication.sharedApplication().openURL(phoneURL)
        }
    }
}
