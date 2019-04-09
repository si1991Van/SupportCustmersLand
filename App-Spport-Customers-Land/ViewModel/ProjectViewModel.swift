//
//  ProjectViewModel.swift
//  App-Spport-Customers-Land
//  Created by apple on 1/22/19.
//  Copyright © 2019 haiphat. All rights reserved.

import Foundation

class ProjectViewModel{
    var projectResponse: [ProjectItemResponse] = []
    
    func getItem(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void  {
//        DgmWaiting.sharedInstance().show()
        Api.Project.getItem(completion : {
            response in
            DispatchQueue.main.async {
                self.projectResponse.removeAll()
                if response.isSuccess(){
                    let status = response.json()?["status"].int
                    let message = response.json()?["message"].string
                    if status == 200{
                        let data = Convertor.convertArray(response.json()!["data"]) {
                            json -> ProjectItemResponse in
                            var projectItem = ProjectItemResponse()
                            projectItem.id = json["id"].int
                            projectItem.name = json["name"].string
                            projectItem.email = json["email"].string
                            projectItem.description = json["description"].string
                            projectItem.hotline = json["hotline"].string
                            projectItem.image_url = json["image_url"].string
                            projectItem.rank_project = json["rank_project"].int
                            return projectItem
                        }
                        self.projectResponse.append(contentsOf: data)
                        onSuccess()
                    }else{
                        onFail(message)
                    }
                }
            }
        })
    }
}

extension ProjectViewModel {
    func getDataForCell(_ index:Int) -> ProjectItemResponse?{
        if projectResponse.count > index {
            return projectResponse[index]
        }
        return nil
    }
}

