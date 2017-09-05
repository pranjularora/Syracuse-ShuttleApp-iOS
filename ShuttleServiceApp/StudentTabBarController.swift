//
//  StudentTabBarController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 12/5/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class StudentTabBarController: UITabBarController
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
