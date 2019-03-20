//
//  ForgotPasswordViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/22/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ForgotPasswordViewModel : NSObject{
    var phone: String?
}

extension ForgotPasswordViewModel{
    
    func forgotPassword(onSuccess : @escaping (String?) -> Void,onFail : @escaping (String?) -> Void) -> Void  {
        Api.Auth.forgotPassword(phone, completion : {
            response in
            DispatchQueue.main.async {
                if response.isSuccess(){
                    let status = response.json()?["status"].int
                    let message = response.json()?["message"].string
                    if status == 200{
                        onSuccess(message)
                    }else{
                        onFail(message)
                    }
                }
            }
        })
    }
}
extension ForgotPasswordViewModel{
    func validate() -> String?{
        var ret : String? = nil
        if !Validator.validateRequired(phone)!{
            ret = Loc("filed_error_email_blank")
        }
        return ret
    }
}
