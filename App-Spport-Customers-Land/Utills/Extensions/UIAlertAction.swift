//
//  UIAlertAction.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/24/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertAction {
    func setTextColor(textColor: UIColor?){
        if let color = textColor {
            self.setValue(color, forKey: "titleTextColor")
        }
    }
    func setImageTintColor(textColor: UIColor?){
        if let color = textColor {
            self.setValue(color, forKey: "imageTintColor")
        }
    }
}
