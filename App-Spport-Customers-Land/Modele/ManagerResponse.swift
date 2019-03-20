//
//  ManagerResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/12/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class ListManagerResponse: BaseListResponse<ManagerResponse>{}

struct ManagerResponse {
    var id : Int?
    var title: String?
    var product_type: Int?
    var land_type: Int?
    var address: String?
    var city_id: Int?
    var district_id: Int?
    var area: Float?
    var area_type: Int?
    var price: Float?
    var price_type: Int?
    var discription: String?
    var fullname: String?
    var phone: String?
    var email: String?
    var status: Int?
    var create_at: String?
    var images: String?
}

