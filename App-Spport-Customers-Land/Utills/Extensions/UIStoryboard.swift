//
//  UIStoryboard.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{
    
    class func initViewController(storyboard storyboardName: String, viewController vcIndentifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: vcIndentifier)
    }
    
}
