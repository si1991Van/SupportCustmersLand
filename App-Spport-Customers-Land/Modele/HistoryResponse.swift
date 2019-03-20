//
//  HistoryResponse.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ListHistoryResponse: BaseListResponse<HistoryTitleResponse>{}

struct HistoryTitleResponse {
    var id: Int?
    var name: String?
    var children: [HistoryItemResponse]?
}
struct HistoryItemResponse {
    var id: Int?
    var name: String?
    var date_payment: String?
    var status: Int?
}
