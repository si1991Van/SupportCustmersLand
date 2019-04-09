//
//  SaleResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ListSaleResponse: BaseListResponse<SaleResponse> {
}

struct SaleResponse {
    var id: Int?
    var transaction_id: Int?
    var fullname: String?
    var avatar: String?
    var name: String?
    var project_name: String?
    var rank: Int?
}
