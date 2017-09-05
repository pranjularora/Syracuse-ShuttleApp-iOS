//
//  DriverTabBarController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 12/6/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class DriverTabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Called when logout button is clicked
    @IBAction func LogoutButtonClicked(sender: AnyObject) {
        
        //Navigates back to root view controller
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
