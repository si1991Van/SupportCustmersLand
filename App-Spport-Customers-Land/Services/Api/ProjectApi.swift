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
    
    func postRatting(_ id: Int?, _ rankProject: Int?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        let params = [
            "id": id ?? 0,
            "rank_project": rankProject ?? 0 ] as [String : Any]
        
        self.post(method: "post-rank-project", params: params, completion: completion)
    }
    
    func postHistory(_ id: Int?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.post(method: "list-history-payment", params: [
            "id": id ?? ""
            ], completion: completion)
    }
    
    func postSaleProject(_ id: Int?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        self.post(method: "list-sale-project", params: [
            "id": id ?? ""
            ], completion: completion)
    }
    
    func postFeedback(_ id: Int?, _ transactionId: Int?, _ saleId: Int?, _ rankSale: Int?, _ note: String?, completion: @escaping (DgmResponse) -> Void) -> Void  {
        var params = ["id": id ?? 0,
                      "transaction_id": transactionId ?? 0,
                      "sale_id": saleId ?? 0,
                      "rank_sale": rankSale ?? 0,] as [String : Any]
        params["note"] = note ?? ""
        self.post(method: "post-feedback", params: params, completion: completion)
    }
    
    
    
}
