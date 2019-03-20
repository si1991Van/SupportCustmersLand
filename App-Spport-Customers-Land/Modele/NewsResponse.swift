//
//  NewsResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ListNewsResponse: BaseListResponse<NewsResponse> {
}

struct NewsResponse {
    var id: Int?
    var title: String?
    var image_url: String?
    var created_at: String?
    var category_id: Int?
    var project_id: Int?
    var content: String?
    var description: String?
    var slug: String?
}
