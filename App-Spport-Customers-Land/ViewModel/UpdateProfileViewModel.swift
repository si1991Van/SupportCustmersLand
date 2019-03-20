//
//  UpdateProfileViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/22/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit
class UpdateProfileViewModel: NSObject {
    var fullName: String?
    var email: String?
    var birthday:String?
}
extension UpdateProfileViewModel{
    
    func updateProfile(onSuccess : @escaping (String?) -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Auth.updateProfile(fullName, email, birthday, completion: { response in
            DispatchQueue.main.async {
                if(response.isSuccess()){
                    let status = response.json()?["status"].int
                    let message = response.json()?["message"].string
                    if status == 200 {
                        if let data = response.json()?["data"] {
                            var userResponse = UserResponse.init()
                            userResponse.id = data["id"].int
                            userResponse.email = data["email"].string
                            userResponse.fullname = data["fullname"].string
                            userResponse.avatar = data["avatar"].string
                            userResponse.birthday = data["birthday"].string
                            userResponse.address = data["address"].string
                            userResponse.gender = data["gender"].string
                            UserService.sharedInstance.saveUserInfor(userResponse)
                        }
                        onSuccess(message)
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
