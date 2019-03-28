//
//  BaseViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/31/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class BaseViewController: UIViewController,MFMailComposeViewControllerDelegate{
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.localization()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func localization(){
    }
    
    func setBaseTitile(_ txtTitle: UILabel? , _ name: String?){
        txtTitle?.text = name
    }
    
    func sendEmail() {
        if !MFMailComposeViewController.canSendMail() {
            Toast.error("Bạn chưa đăng nhập mail trên thiết bị")
            return
        }else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["vtechhomes@gmail.com"])
            composeVC.setSubject("Góp ý!")
            composeVC.setMessageBody("", isHTML: false)
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
}

