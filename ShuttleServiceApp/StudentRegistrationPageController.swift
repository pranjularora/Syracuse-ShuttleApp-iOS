//
//  RegistrationPageController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/25/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//
import UIKit

class StudentRegistrationPageController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
   
    var studentRegistrationPageObject = StudentRegistrationPage() //Model Object
   
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    

    @IBOutlet var textField: UITextField!
    @IBOutlet var suid_TextField: UITextField!
    @IBOutlet var textField_Address: UITextField!
    @IBOutlet var name_TextField:UITextField!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var registerButton: UIButton!
    
    var regItemStore = RegisteredItemStore()
    
    //Function that shows a success alert message
    func showSuccessAlert()
    {
        let ac = UIAlertController(title: "Registration Successful",
                                   message: "",
                                   preferredStyle: .ActionSheet)
        
        
        let newGameAction = UIAlertAction(title: "OK",
                                          style: .Default ,
                                          handler: { (action) -> Void in
                                            self.name_TextField.text = ""
                                            self.textField_Address.text = ""
                                            self.textField.text = ""
                                            self.suid_TextField.text = ""
        })
        ac.addAction(newGameAction)
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    //Function that shows an error alert Message
    func showErrorAlert(msg: String)
    {
        let ac = UIAlertController(title: "Error",
                                   message: msg,
                                   preferredStyle: .ActionSheet)
        
        
        let newGameAction = UIAlertAction(title: "OK",
                                          style: .Default ,
                                          handler: { (action) -> Void in
                                            self.viewDidLoad()
        })
        ac.addAction(newGameAction)
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    //When logout button is clicked
    @IBAction func LogoutButtonClicked(sender: AnyObject) {
         self.navigationController?.popToRootViewControllerAnimated(true) //Goes back to root view controller
    }
    
    //function called when view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        tableView.hidden = true
        suid_TextField.delegate = self
        name_TextField.autocorrectionType = UITextAutocorrectionType.No
        textField_Address.autocorrectionType = UITextAutocorrectionType.No
        
        // Manage tableView visibility via TouchDown in textField
        textField.addTarget(self, action: #selector(textFieldActive), forControlEvents: UIControlEvents.TouchDown)        
        
    }
    
    //Function called when view disappears
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        regItemStore.saveChanges()  //Saving registerred items to file
    }
    
    //Delegate for suid text field
    func textField(textField_checker: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField_checker == textField){
            return false
        }
        else if (textField_checker == suid_TextField)
        {
            // only digits allowed of length at max 9
            let maxLength = 9
            let currentString: NSString = suid_TextField.text!
            let newString: NSString = currentString.stringByReplacingCharactersInRange(range, withString: string)
            if (newString.length > maxLength){
                return false // if max length it will always return false
            }
            
            let allowedValues = NSCharacterSet(charactersInString:"0123456789").invertedSet
            let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(allowedValues)
            let result = compSepByCharInSet.joinWithSeparator("")
            return string == result
        }
        return false
    }
    
    //Function called when registration button clicked
    @IBAction func Register_buttonClicked(sender: AnyObject) {
        
        if(name_TextField.text != "" && suid_TextField.text != "" && textField_Address.text != "" && textField.text != "")
        {
            for item in regItemStore.allRegisteredItems
            {
                if(item.suid == Int(suid_TextField.text!)! && item.time == textField.text!)
                {
                    showErrorAlert("Duplicate value. \(suid_TextField.text!) already registerred for \(textField.text!)")
                    return
                }
            }
            if(suid_TextField.text?.characters.count == 9)
            {
                let regItem = RegisterItem(name: name_TextField.text!,suid: Int(suid_TextField.text!)!,time: textField.text!,address: textField_Address.text!)
                regItemStore.addItem(regItem)
                showSuccessAlert()
                regItemStore.saveChanges() //Save values to files
            }
            else
            {
                showErrorAlert("Invalid SUID ENTERRED")
            }
        }
        else{
            showErrorAlert("Please Enter All Details")
        }
    }
    
    //Function called when user taps the background
    @IBAction func UserTappedTheBackground(gestureRecogniser: UITapGestureRecognizer)
    {
        gestureRecogniser.cancelsTouchesInView = false
        suid_TextField.resignFirstResponder()
        name_TextField.resignFirstResponder()
        textField.resignFirstResponder()
        textField_Address.resignFirstResponder()
    }
    
    // Manage keyboard and tableView visibility
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        guard let touch:UITouch = touches.first else
        {
            return;
        }
        if touch.view != tableView
        {
            textField.endEditing(true)
            tableView.hidden = true
        }
    }
    
    // Toggle the tableView visibility when click on textField
    func textFieldActive() {
        tableView.hidden = !tableView.hidden
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // returns number of sections in table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // returns number of rows in section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentRegistrationPageObject.values.count;
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        // Set text from the data model
        cell.textLabel?.text = studentRegistrationPageObject.values[indexPath.row]
        cell.textLabel?.font = textField.font
        return cell
    }
    
    //called when a row is selected from the drop down list
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        textField.text = studentRegistrationPageObject.values[indexPath.row]
        tableView.hidden = true
        textField.endEditing(true)
    }
    
    //returns height for head of the section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
}
