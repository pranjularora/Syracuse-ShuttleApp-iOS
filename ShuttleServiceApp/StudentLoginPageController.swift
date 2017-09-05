//
//  LoginPage.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/24/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
class StudentLoginPageController: UIViewController{
    
  
    @IBOutlet var netIdTextField: UITextField? //net id text field
    @IBOutlet var passwordTextField: UITextField? //Password text field
    @IBOutlet var login: UIButton? //Login button
    
    var studentLoginPageObject = StudentLoginPage() //Model object
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }    
    
    //Fuction that shows an alert message specifying the error
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
    
    //When user presses the login button
    @IBAction func LoginButton(button : UIButton)
    {
        var uIndex: Int?
        var flag: Int = 0
        
        //Login functionality, checkin for valid username and password
        if let a = netIdTextField!.text
        {
            for item in studentLoginPageObject.username {
                if item == a
                {
                    uIndex = studentLoginPageObject.username.indexOf(item)
                    flag = 1
                    break
                }
            }
            if(flag == 1)
            {
                if passwordTextField!.text == studentLoginPageObject.password[uIndex!]
                {
                    self.performSegueWithIdentifier("NavigateToReg", sender: self)
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
    
    //when user taps the background
    @IBAction func UserTappedTheBackground(gestureRecogniser: UITapGestureRecognizer)
    {
        netIdTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    }
}