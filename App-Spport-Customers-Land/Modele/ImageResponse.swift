//
//  ImageResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ImageResponse {
    var status: Bool?
    var message: String?
    var data: LinkResponse?
}

struct LinkResponse{
    var url: String?
    
    init(url : String?) {
        self.url = url
    }
    init() {
        
    }
}
