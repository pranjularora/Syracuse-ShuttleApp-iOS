//
//  MainPage.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/25/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class MainPage: UIViewController{
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var headingView: UIView!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var navigationButton: UIButton!
    @IBOutlet var emergencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 70))
        
        headingView.backgroundColor = UIColor.lightGrayColor()
        
        self.view.addSubview(headingView)
        
        registerButton!.backgroundColor = UIColor.lightGrayColor()
        registerButton!.layer.cornerRadius = 10
        
        navigationButton!.backgroundColor = UIColor.lightGrayColor()
        navigationButton!.layer.cornerRadius = 10
        
        emergencyButton!.backgroundColor = UIColor.lightGrayColor()
        emergencyButton!.layer.cornerRadius = 10
        
        
        
    }
}
