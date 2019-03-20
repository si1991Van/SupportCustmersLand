//
//  UIColor.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static var primary : UIColor {
        get {
            return hex("#138090")
        }
    }
    static var defaultBackground : UIColor {
        get {
            return hex("#F5F5F5")
        }
    }
    static var defaultTextColor : UIColor {
        get {
            return hex("#333333")
        }
    }
    static var greenBackground : UIColor {
        get {
            return hex("#a8c138")
        }
    }
    
    static var transparent : UIColor {
        get {
            return hex("#FF000000")
        }
    }
    class func hex(_ hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            let reqIndex = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[..<reqIndex])
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    func colorCode() -> UInt {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        {
            var colorAsUInt : UInt = 0
            
            colorAsUInt += UInt(red * 255.0) << 16 +
                UInt(green * 255.0) << 8 +
                UInt(blue * 255.0)
            return colorAsUInt
        }
        return 0xCC6699
    }
}
