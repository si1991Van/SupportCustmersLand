//
//  BaseResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/31/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation

class BaseResponse<T>{
    var token:String?
    var message:String?
    var data: T?
}
