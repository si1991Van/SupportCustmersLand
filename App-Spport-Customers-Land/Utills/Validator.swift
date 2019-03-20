//
//  Validator.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import UIKit

class Validator: NSObject {
    static func validateRequired(_ field: String? = nil) -> Bool? {
        if field == nil || field!.isEmpty  {
            return false
        } else {
            return true
        }
    }
    
    static func validateEmail(_ field: String?) -> Bool? {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: field)
    }
    static func validateEqual(_ firstField: String?, _ secondField:String?) ->Bool?{
        if validateRequired(firstField)! && validateRequired(secondField)! {
            return (firstField == secondField)
        } else {
            return false
        }
    }
    
    static func validateLenght(_ field: String? = nil) -> Bool{
        if (field?.count)! < 6 {
            return false
        }else{
            return true
        }
    }
    
    static func validateUrl(_ stringUrl: String?) ->Bool{
        if let _stringUrl = stringUrl,let url = URL.init(string: _stringUrl)  {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
}
