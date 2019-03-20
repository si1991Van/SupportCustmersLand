//
//  BaseListResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/24/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class BaseListResponse <T> {
    var token:String?
    var message:String?
    var data: [T]?
}
