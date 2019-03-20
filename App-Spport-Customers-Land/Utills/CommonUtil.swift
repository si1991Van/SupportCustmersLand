//
//  CommonUtil.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit

class CommonUti {
    func sendEmail() {
        if !MFMailComposeViewController.canSendMail() {
            Toast.error("không có email")
            return
        }else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["address@example.com"])
            composeVC.setSubject("Hello!")
            composeVC.setMessageBody("Hello from California!", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
}
