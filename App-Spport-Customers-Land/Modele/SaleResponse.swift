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
    var id: String?
    var transaction_id: String?
    var fullname: String?
    var avatar: String?
    var name: String?
    var project_name: String?
    var rank: Int?
}
