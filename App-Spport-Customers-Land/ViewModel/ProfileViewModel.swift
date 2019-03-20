//
//  ProfileViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/10/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit



class ProfileViewModel {
    
    
    func changeAvatar(_ image: UIImage,onSuccess: @escaping (String?) -> Void, onError: @escaping (String?) -> Void) {
        DgmWaiting.sharedInstance().show()
        Api.Auth.changeAvatar(image,completion: {
            response in
            DispatchQueue.main.async {
                if response.isSuccess() {
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
                    } else {
                        onError(response.errorMessage)
                    }
                }
                
            }
        })
    }
    
    
    struct ProfileResponse {
        let title: String
        let image: UIImage
    }
    
    
    let item = [
        ProfileResponse(title: Loc("lable-update-information"), image: #imageLiteral(resourceName: "ic-update-information")),
        ProfileResponse(title: Loc("lable-change-password"), image: #imageLiteral(resourceName: "ic-change-password")),
        ProfileResponse(title: Loc("lable-booking"), image: #imageLiteral(resourceName: "ic-expand")),
        ProfileResponse(title: Loc("lable-setting"), image: #imageLiteral(resourceName: "ic-setting")),
    ]
    
    let itemHepl = [
        ProfileResponse(title: Loc("lable-profile_share"), image: #imageLiteral(resourceName: "ic_share")),
        ProfileResponse(title: Loc("lable-profile-rateting"), image: #imageLiteral(resourceName: "ic-rateting")),
        ProfileResponse(title: Loc("lable-profile-send-email"), image: #imageLiteral(resourceName: "ic-email")),
        ProfileResponse(title: Loc("lable-profile-info"), image: #imageLiteral(resourceName: "ic-info")),
        ]
    
}
