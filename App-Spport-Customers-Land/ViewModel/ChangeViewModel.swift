//
//  ChangeViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/22/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ChangeViewModel: NSObject {
    var currentPassword: String?
    var newPassword: String?
    var confirmPassword: String?
}
extension ChangeViewModel{
    
    func changePassword(onSuccess : @escaping (String?) -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Auth.changePassword(currentPassword, newPassword, confirmPassword, completion : {
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

extension ChangeViewModel{
    func validate() -> String?{
        var ret : String? = nil
        if !Validator.validateRequired(currentPassword)!{
            ret = Loc("filed_error_current_password_blank")
        }else if !Validator.validateLenght(currentPassword){
            ret = Loc("filed_error_password_lenght")
        }else if !Validator.validateRequired(newPassword)!{
            ret = Loc("filed_error_new_password_blank")
        }else if !Validator.validateLenght(newPassword){
            ret = Loc("filed_error_password_lenght")
        }else if !Validator.validateRequired(confirmPassword)!{
            ret = Loc("filed_error_new_confirm_password_blank")
        }else if !Validator.validateEqual(newPassword, confirmPassword)!{
            ret = Loc("filed_error_new_password_not_equal")
        }
        return ret
    }
}
