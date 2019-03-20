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

class BaseViewController: UIViewController{
 
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
            Toast.error("không có email")
            return
        }else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["address@example.com"])
            composeVC.setSubject("Hello!")
            composeVC.setMessageBody("Hello from California!", isHTML: false)
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
}
