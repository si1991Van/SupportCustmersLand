//
//  SaleViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class SaleViewModel: NSObject{
    var transactionId: String?
    var note: String?
    var rank: Int?
    var saleId: String?
    var id: String?
    var item: [SaleResponse] = []
}
extension SaleViewModel{
    
    func getSale(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Project.postSaleProject(id, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    let data = Convertor.convertArray(response.json()!["data"]) {
                        json -> SaleResponse in
                        var saleResponse = SaleResponse()
                        saleResponse.id = json["id"].string
                        saleResponse.name = json["name"].string
                        saleResponse.fullname = json["fullname"].string
                        saleResponse.project_name = json["project_name"].string
                        saleResponse.transaction_id = json["fullname"].string
                        saleResponse.avatar = json["fullname"].string
                        saleResponse.rank = json["fullname"].int
                        return saleResponse
                    }
                    self.item.append(contentsOf: data)
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
        })
    }
    
    func postFeedback(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Project.postFeedback(id, transactionId, saleId, String(describing: rank), note, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
        })
    }
    
    
}


