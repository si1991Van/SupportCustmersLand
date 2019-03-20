//
//  LoginViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/31/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginViewModel: NSObject {
    var email : String?
    var password: String?
}


extension LoginViewModel{
    
    func login(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Auth.login(email, password, completion: {
            response in
            DispatchQueue.main.async {
                if response.isSuccess() {
                    let status = response.json()?["status"].int
                    let message = response.json()?["message"].string
                    if status == 200 {
                        if let data = response.json()?["data"] {
                            var userResponse = UserResponse.init()
                            userResponse.token = data["token"].string
                            userResponse.id = data["id"].int
                            userResponse.email = data["email"].string
                            userResponse.fullname = data["fullname"].string
                            userResponse.avatar = data["avatar"].string
                            userResponse.birthday = data["birthday"].string
                            userResponse.address = data["address"].string
                            userResponse.gender = data["gender"].string
                            userResponse.phone = data["phone"].string
                            UserService.sharedInstance.saveUserInfor(userResponse)
                            UserService.sharedInstance.saveToken(accessToken: userResponse.token)
                        }
                        onSuccess()
                    }else{
                        onFail(message)
                    }
                }else{
                    onFail(response.errorMessage)
                }
                    
            }
        })
    }
}

extension LoginViewModel {
    func validate() -> String?{
        var ret : String? = nil
        if !Validator.validateRequired(email)!{
            ret = Loc("filed_error_email_blank")
        }else if !Validator.validateRequired(password)! {
            ret = Loc("filed_error_password_blank")
        }else if !Validator.validateLenght(password){
            ret = Loc("filed_error_password_lenght")
        }
        return ret
    }
}
