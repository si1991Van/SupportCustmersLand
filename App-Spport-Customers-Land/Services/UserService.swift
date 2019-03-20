//
//  UserService.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserService {
    
    fileprivate static var instance : UserService?
    
    static var sharedInstance: UserService{
        if (instance == nil) {
            instance = UserService()
        }
        return instance!
    }
    
    static var userInfo: UserResponse? {
        return sharedInstance.userInfo
    }
    
    static var accessToken: String? {
        return sharedInstance.accessToken
    }
    
    static func destroy() {
        instance = nil
    }
    
    var accessToken : String?{
        get {
            if let token = UserDefaults.standard.object(forKey: "token") as? String {
                return token
            }
            return nil
        }
        set (newValue) {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: "token")
            }
            
        }
    }
    var userInfo: UserResponse?{
        get{
            var userResponse = UserResponse.init()
            userResponse.id = UserDefaults.standard.object(forKey: "id") as? Int
            userResponse.email = UserDefaults.standard.object(forKey: "email") as? String
            userResponse.fullname = UserDefaults.standard.object(forKey: "fullname") as? String
            userResponse.avatar = UserDefaults.standard.object(forKey: "avatar") as? String
            userResponse.birthday = UserDefaults.standard.object(forKey: "birthday") as? String
            userResponse.address = UserDefaults.standard.object(forKey: "address") as? String
            userResponse.gender = UserDefaults.standard.object(forKey: "gender") as? String
            userResponse.phone = UserDefaults.standard.object(forKey: "phone") as? String
            return userResponse
        }
        set (_userInfo){
            UserDefaults.standard.set(_userInfo?.id, forKey: "id")
            UserDefaults.standard.set(_userInfo?.email, forKey: "email")
            UserDefaults.standard.set(_userInfo?.fullname, forKey: "fullname")
            UserDefaults.standard.set(_userInfo?.avatar, forKey: "avatar")
            UserDefaults.standard.set(_userInfo?.birthday, forKey: "birthday")
            UserDefaults.standard.set(_userInfo?.address, forKey: "address")
            UserDefaults.standard.set(_userInfo?.gender, forKey: "gender")
            UserDefaults.standard.set(_userInfo?.phone, forKey: "phone")
        }
        
    }
}

extension UserService{
    
    func saveToken(accessToken: String?){
        self.accessToken = accessToken
    }
    
    func saveUserInfor(_ userInfo: UserResponse?) {
        self.userInfo = userInfo
    }
    
    
}

extension UserService {
    var isLoggedIn: Bool {
        return accessToken != nil
    }
    
    func logout() {
        deleteUserData()
        accessToken = nil
        userInfo = nil
         //Log out account
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.goToLogin()
        }
    }
    
    internal func deleteUserData(){
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "fullname")
        UserDefaults.standard.removeObject(forKey: "avatar")
        UserDefaults.standard.removeObject(forKey: "birthday")
        UserDefaults.standard.removeObject(forKey: "address")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.synchronize()
    }
    
}
