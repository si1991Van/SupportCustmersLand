//
//  SupportViewMode.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
class SupportViewMode: NSObject {
    var id : Int?
    var rating: Int?
    var phone: String?
    var email: String?
    var link : String?
    var title: String?
}

extension SupportViewMode{
    func postRattingProject(onSuccess : @escaping (String?) -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Project.postRatting(id, rating, completion: {
            response in DispatchQueue.main.async {
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    onSuccess(message)
                }else{
                    onFail(message)
                }
            }
        })
    }
}
