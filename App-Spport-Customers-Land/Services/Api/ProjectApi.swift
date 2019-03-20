//
//  ProjectApi.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/22/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class ProjectApi: DgmApi {
    
    var apiUrl: String {
        get {
            return Config.API_URL
        }
    }
    
    var apiEndpoint: String {
        get {
            return "project/"
        }
    }
    
    func getItem(completion: @escaping (DgmResponse) -> Void) -> Void {
       self.get(queryString: "list-project", completion: completion)
    }
    
    func postRatting(_ id: String?, _ rankProject: String?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.post(method: "post-rank-project", params: [
            "id": id ?? "",
            "rank_project": rankProject ?? ""
            ], completion: completion)
    }
    
    func postHistory(_ id: Int?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.post(method: "list-history-payment", params: [
            "id": id ?? ""
            ], completion: completion)
    }
    
    func postSaleProject(_ id: String?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.post(method: "list-sale-project", params: [
            "id": id ?? ""
            ], completion: completion)
    }
    
    func postFeedback(_ id: String?, _ transactionId: String?, _ saleId: String?, _ rankSale: String?, _ note: String?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.post(method: "post-feedback", params: [
            "id": id ?? "",
            "transaction_id": transactionId ?? "",
            "sale_id": saleId ?? "",
            "rank_sale": rankSale ?? "",
            "note": note ?? ""
            ], completion: completion)
    }
    
    
    
}
