//
//  OtherFuncTableViewController.swift
//  ShuttleServiceApp
//
//  Created by Nikhil Prashar on 11/26/16.
//  Copyright © 2016 Nikhil Prashar. All rights reserved.
//

import UIKit
import MessageUI

class OtherFuncTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    var otherFuncTableViewObject = OtherFuncTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //returns the number of sections in the table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 3
    }
    
    //Returns number of rows in sections
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        if (section == 0 || section == 2)
        {
            return 1
        }
        return 2
    }
    
    //When a row is selected from the table
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //When row that specifies to send a mail is clicked
        if (indexPath.section == 2 && indexPath.row == 0)
        {
            let mailComposeViewController = ComposeEmail()
            if MFMailComposeViewController.canSendMail()
            {   //If mail can be sent
                self.presentViewController(mailComposeViewController, animated: true, completion: nil) //Mail view is popped up
            }
            else
            {
                self.showSendEmailErrorAlert() //Error message that mail cannot be sent
            }
        }
        
        //If call dps row is selected
        if(indexPath.section == 1 && indexPath.row == 0)
        {
            if let dps = NSURL(string: "tel://"+otherFuncTableViewObject.dpsPhoneNumber) //Specifies NSURL as the phone number to be called
            {
                UIApplication.sharedApplication().openURL(dps) //opens the specified url i.e makes the phone call
            }
        }
        
        //When call medical services row is clicked
        if(indexPath.section == 1 && indexPath.row == 1)
        {
            if let medicalServices = NSURL(string: "tel://"+otherFuncTableViewObject.medicalServicesPhoneNumber) //Speciies th phone number to be called
            {
                UIApplication.sharedApplication().openURL(medicalServices) //opens the specified url i.e makes the phone call
            }
        }
    }
    
    func ComposeEmail() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(otherFuncTableViewObject.emailToRecepients)
        mailComposeVC.setSubject(otherFuncTableViewObject.emailSubject)
        mailComposeVC.setMessageBody(otherFuncTableViewObject.emailBody, isHTML: false)
        return mailComposeVC
    }
    
    //Function that shows error alert message
    func showSendEmailErrorAlert()
    {
        let emailErrorAlert = UIAlertController(title: "Email could not be sent!!", message: "Your device could not send the email", preferredStyle: .ActionSheet)
        let errorAction = UIAlertAction(title: "OK",
                                          style: .Default ,
                                          handler: { (action) -> Void in
                                            self.viewDidLoad()
        })
        emailErrorAlert.addAction(errorAction)
        
        presentViewController(emailErrorAlert, animated: true, completion: nil)
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResultCancelled:
            print("Mail cancelled")
        case MFMailComposeResultSaved:
            print("Mail saved")
        case MFMailComposeResultSent:
            showSuccessAlert()
        case MFMailComposeResultFailed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Function returns a success alert message
    func showSuccessAlert()
    {
        let ac = UIAlertController(title: "Mail Sent",
                                   message: "",
                                   preferredStyle: .ActionSheet)
        
        
        let newGameAction = UIAlertAction(title: "OK",
                                          style: .Default ,
                                          handler: { (action) -> Void in
                                            self.viewDidLoad()
        })
        ac.addAction(newGameAction)
        
        presentViewController(ac, animated: true, completion: nil)
    }
    

}
