//
//  LoginPage.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/24/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class DriverLoginPageController: UIViewController{
    
    
    @IBOutlet var driverIdTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var login: UIButton?
    
    var driverLoginPageObject = DriverLoginPage() //Model Object
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Function that shows error alert message
    func showErrorAlert()
    {
        let ac = UIAlertController(title: "Error",
                                   message: "Incorrect Credentials",
                                   preferredStyle: .ActionSheet)
        
        
        let newGameAction = UIAlertAction(title: "OK",
                                          style: .Default ,
                                          handler: { (action) -> Void in
                                            self.viewDidLoad()
        })
        ac.addAction(newGameAction)
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    //Function called when login button is pressed
    @IBAction func LoginButton(button : UIButton)
    {
        var uIndex: Int?
        var flag: Int = 0
        
        //Login functionality, checkin for valid username and password
        if let a = driverIdTextField!.text
        {
            for item in driverLoginPageObject.username {
                if item == a
                {
                    uIndex = driverLoginPageObject.username.indexOf(item)
                    flag = 1
                    break
                }
            }
            if(flag == 1)
            {
                if passwordTextField!.text == driverLoginPageObject.password[uIndex!]
                {
                    self.performSegueWithIdentifier("NavigateToShowRegistrations", sender: self)
                }
                else{
                    showErrorAlert()
                }
            }
            else
            {
                showErrorAlert()
            }
        }
    }
    
    //When user taps the background
    @IBAction func UserTappedTheBackground(gestureRecogniser: UITapGestureRecognizer)
    {
        driverIdTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }
}