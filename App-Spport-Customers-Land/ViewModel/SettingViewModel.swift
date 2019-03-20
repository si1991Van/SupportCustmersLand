//
//  SettingViewModel.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/30/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation

class SettingViewModel: NSObject {
    
    var settingResponse: [SettingResponse] = []
    
}
extension SettingViewModel {
    func getSetting(onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Auth.getSetting(completion: {
            response in DispatchQueue.main.async{
                let status = response.json()?["status"].int
                let message = response.json()?["message"].string
                if status == 200{
                    let data = Convertor.convertArray(response.json()!["data"]) {
                        json -> SettingResponse in
                        var response = SettingResponse()
                        response.id = json["id"].int
                        response.name = json["name"].string
                        response.status = json["status"].bool
                        return response
                    }
                    self.settingResponse.append(contentsOf: data)
                    onSuccess()
                }else{
                    onFail(message)
                }
            }
        })
    }
    
    func postSetting(id: Int?, status: Bool?, onSuccess : @escaping () -> Void,onFail : @escaping (String?) -> Void) -> Void {
        Api.Auth.postSetting(id, status, completion: {
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

extension SettingViewModel{
    
    func getActionForCell(section: Int,index: Int)-> SettingResponse?{
        if settingResponse.count > index {
            return self.settingResponse[index]
        }
        return nil
    }
}
