//
//  NewsApi.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class NewsApi: DgmApi {
    
    var apiUrl: String {
        get {
            return Config.API_URL
        }
    }
    
    var apiEndpoint: String {
        get {
            return "news/"
        }
    }
    
    func getCategory(completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.get(queryString: "list-category", completion: completion)
    }
    
    func postItemCategroy(_ projectId: Int?, _ categoryId: Int?, _ page: Int?, _ current: Int?, completion: @escaping (DgmResponse)-> Void) -> Void {
        self.post(method: "list-news", params: [
            "project_id": projectId ?? "",
            "category_id": categoryId ?? "",
            "page": page ?? "",
            "number_record": current ?? ""], completion: completion)
    }
}

