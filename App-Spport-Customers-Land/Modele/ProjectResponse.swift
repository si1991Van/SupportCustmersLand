//
//  PrjectResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/24/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class ProjectResponse: BaseListResponse<ProjectItemResponse>{}

struct ProjectItemResponse {
    var id: Int?
    var name: String?
    var image_url: String?
    var hotline: String?
    var email: String?
    var description: String?
    var rank_project: String?
    
}
