//
//  LoginResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/31/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation

class LoginResponse: BaseResponse<UserResponse> {
    
}


struct UserResponse {
    var token: String?
    var id: Int?
    var email: String?
    var fullname: String?
    var birthday: String?
    var avatar: String?
    var phone: String?
    var gender: String?
    var address: String?
}
