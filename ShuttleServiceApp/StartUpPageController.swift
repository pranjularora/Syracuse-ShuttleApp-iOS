//
//  StartUpPageController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/28/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class StartUpPageController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    
    @IBAction func ForStudentButtonClicked(sender: AnyObject) {
    self.performSegueWithIdentifier("NavigateToStudentLogin", sender: self)
    }
    
    
    @IBAction func ForDriverButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("NavigateToDriverLogin", sender: self)
    }
    
}
