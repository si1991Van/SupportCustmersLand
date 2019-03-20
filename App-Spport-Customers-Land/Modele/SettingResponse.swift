//
//  SettingResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ListSettingResponse: BaseListResponse<SettingResponse> {
}

struct SettingResponse {
    var id: Int?
    var name: String?
    var status: Bool?
    
}
