//
//  GetOptionManagerResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class GetOptionManagerResponse: BaseResponse<OptionResponse> {}

struct OptionResponse{
    var product_type: [ProductResponse]?
    var city: [CityResponse]?
    var area: [BaseOption]?
    var price_type: [BaseOption]?
    
}

class ProductResponse: BaseOption{
    var children: [BaseOption]?
}

class CityResponse: BaseOption {
    var district: [BaseOption]?
}

class BaseOption{
    var id : Int?
    var name: String?
    var type: Int?
}
