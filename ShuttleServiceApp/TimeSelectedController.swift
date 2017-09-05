//
//  TimeSelectedController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 12/5/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit

class TimeSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var values = ["10:30", "11:00", "11:30", "12:00", "12:30", "1:00", "1:30", "2:00", "2:30", "3:00", "3:30"]
    
    let cellReuseIdentifier = "cell"
    
   
    
    // Using simple subclass to prevent the copy/paste menu
    // This is optional, and a given app may want a standard UITextField
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var name_TextField:UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var goButton: UIButton!
    var selectedTime:String! = ""
    var regItem = RegisteredItemStore()
    var arrayOfItems = [RegisterItem]()
    
   @IBAction func GoButtonClicked(sender: AnyObject) {
    selectedTime = textField.text
    arrayOfItems.removeAll()
    
    print("address: \(regItem.allRegisteredItems)")
    
    for item in regItem.allRegisteredItems
    {
        if(item.time == selectedTime)
        {
            arrayOfItems.append(item)
        }
    }
    
    if(arrayOfItems.count == 0)
    {
        let ac = UIAlertController(title: "No Registrations Found",
                                   message: "",
                                   preferredStyle: .ActionSheet)
        
        let newGameAction = UIAlertAction(title: "OK",
                                          style: .Default ,
                                          handler: { (action) -> Void in
                                            self.viewDidLoad()
        })
        ac.addAction(newGameAction)
        
        presentViewController(ac, animated: true, completion: nil)
        return
    }
    else{
       
        self.performSegueWithIdentifier("NavigateToMapView", sender: self)
    }
    
   }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let mvc = segue.destinationViewController as! MapViewController
        
        if (segue.identifier == "NavigateToMapView")
        {
            mvc.arrayOfItemsFromPreviousView = arrayOfItems
            print("Addresses: \(arrayOfItems)")
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        
        tableView.hidden = true
        tableView.layer.zPosition = 1
        // Manage tableView visibility via TouchDown in textField
        textField.addTarget(self, action: #selector(textFieldActive), forControlEvents: UIControlEvents.TouchDown)
        
        
    }
    
    
    func textField(textField_checker: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField_checker == textField){
            return false
        }
        
        return false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(textField: UITextField) {
        // TODO: Your app can do something when textField finishes editing
        print("The textField ended editing. Do something based on app requirements.")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        // Set text from the data model
        cell.textLabel?.text = values[indexPath.row]
        cell.textLabel?.font = textField.font
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Row selected, so set textField to relevant value, hide tableView
        // endEditing can trigger some other action according to requirements
        textField.text = values[indexPath.row]
        tableView.hidden = true
        textField.endEditing(true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

}