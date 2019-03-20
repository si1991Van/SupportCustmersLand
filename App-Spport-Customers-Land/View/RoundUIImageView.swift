//
//  RoundUIImageView.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/13/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundUIImageView: UIImageView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
