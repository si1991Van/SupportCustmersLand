//
//  AuthApi.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/31/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import UIKit

class AuthApi: DgmApi {
    
    var apiUrl: String {
        get {
            return Config.API_URL
        }
    }
    
    var apiEndpoint: String {
        get {
            return "user/"
        }
    }
    
    func login(_ username: String?, _ password: String?, completion: @escaping (DgmResponse) -> Void) -> Void {
        
        self.post(method: "login", params: [
            "phone": username ?? "",
            "password": password ?? ""
            ], completion: completion)
    }
    
    func updateProfile(_ fullname: String?, _ email: String?, _ birthday: String?, completion: @escaping (DgmResponse) -> Void) -> Void {
        
        post(method: "update-profile", params: [
            "fullname": fullname ?? "",
            "email": email ?? "",
            "birthday": birthday ?? "",
            ], completion: completion)
    }
    
    func changeAvatar(_ image: UIImage ,completion: @escaping ((DgmResponse) -> Void)){
        self.upload(method: "update-avatar", multipartFormData: {
            (multipartFormData) in
            if let imgData = UIImagePNGRepresentation(image) {
                multipartFormData.append(imgData, withName: "file", fileName: "userAvatar.png", mimeType: "image/png")
            }
        },
                    completion: completion)
    }
    
    func forgotPassword(_ phone: String?, completion: @escaping (DgmResponse) -> Void) -> Void {
        
        post(method: "forgot", params: [
            "phone": phone ?? "",
            ], completion: completion)
    }
    
    func changePassword(_ currentPassword: String?, _ newPassword: String?, _ newPasswordConfirmation: String?, completion: @escaping (DgmResponse) -> Void) -> Void {
        
        post(method: "change-password", params: [
            "current_password": currentPassword ?? "",
            "new_password": newPassword ?? "",
            "new_password_confirmation": newPasswordConfirmation ?? "",
            ], completion: completion)
    }
    
    
    func getProfile(completion: @escaping ((DgmResponse) -> Void)) -> Void {
        get(queryString: "get-profile", completion: completion)
    }
    
    func logOut(_ fcmToken: String?, completion: @escaping ((DgmResponse) -> Void)) -> Void {
        post(method: "logout", params: [
            "fcm_token": fcmToken ?? "",
            ], completion: completion)
    }
    
    func getSetting(completion: @escaping ((DgmResponse) -> Void)) -> Void {
        get(queryString: "get-follower", completion: completion)
    }
    
    func postSetting(_ id: Int?, _ status: Bool?, completion: @escaping ((DgmResponse) -> Void)) -> Void {
        post(method: "post-follower", params: [
            "id": id ?? "",
            "status": status ?? false,
            ], completion: completion)
    }
    
    func postBooked(_ fullName: String?, _ phone: String?, _ email: String?, _ timeView: String?, _ note: String?, completion: @escaping ((DgmResponse) -> Void)) -> Void {
        post(method: "booking-view-house", params: [
            "fullname": fullName ?? "",
            "phone": phone ?? false,
            "email": email ?? false,
            "time_view": timeView ?? false,
            "note": note ?? false,
            ], completion: completion)
    }
    
    func updateNotificationToken(typeDevice: String?, deviceName: String?, deviceId: String?, token: String?, completion: @escaping ((DgmResponse) -> Void)) {
        self.post(method: "update-token-fire-base", params: [
            "type_device": typeDevice ?? "",
            "device_name": deviceName ?? false,
            "device_id": deviceId ?? false,
            "token": token ?? false
            ], completion: completion)
    }

    
}
