//
//  FCMNotificationService.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/11/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import SwiftMessages
import SwiftyJSON
import Kingfisher

class FCMNotificationService {
    fileprivate static var instance : FCMNotificationService?
    var devicesName = UIDevice.current.name
    var devicesId = UIDevice.current.identifierForVendor!.uuidString
    static var sharedInstance: FCMNotificationService{
        if (instance == nil) {
            instance = FCMNotificationService()
        }
        return instance!
    }
    
    init() {
        
    }
    
    var token: String {
        get {
            if let token = UserDefaults.standard.object(forKey: "deviceFCMToken") as? String {
                return token
            }
            return ""
        }
        set {
            if !newValue.isEmpty && UserService.sharedInstance.isLoggedIn{
                // will be call api update token at there
                // after update token successfull, will be save token in the local memory
                Api.Auth.updateNotificationToken(typeDevice: "2", deviceName: devicesName, deviceId: devicesId, token: newValue, completion: {
                    dmgResponse in if dmgResponse.isSuccess(){
                        UserDefaults.standard.set(newValue, forKey: "deviceFCMToken")
                    }
                })
            }
        }
    }

}

extension FCMNotificationService{
    func receiveActionForNotification(application: UIApplication,userInfo: [AnyHashable: Any]?){
        if application.applicationState == UIApplicationState.inactive || application.applicationState == UIApplicationState.background {
            self.receivedNotificationInBackground(userInfo: userInfo)
        } else {
            self.receivedNotificationInForeground(userInfo: userInfo)
        }
    }
    
    func receivedNotificationInForeground(userInfo: [AnyHashable: Any]?){
        print("FCMNotificationService.receiveNotificationForeground")
        if UserService.sharedInstance.isLoggedIn {
            // di đến màn hình chi tiết tin.
            
            NotificationCenter.default.post( name: NSNotification.Name(DetailNewsViewController.NEW_NOTIFICATION), object: nil)
            let notificationModel = self.makeNotificationModel(userInfo: userInfo)
            
            self.displayNotificationInForeground(notificationModel: notificationModel, completion: {
                self.openingNotification(notification: notificationModel)
            })
        }
    }
    
    func receivedNotificationInBackground(userInfo: [AnyHashable: Any]?){
        print("FCMNotificationService.openingNotification")
        if UserService.sharedInstance.isLoggedIn {
            self.openingNotification(notification: self.makeNotificationModel(userInfo: userInfo))
        }
    }
    
    fileprivate func openingNotification(notification: NotificationViewModel) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.handlePushNotification(notification)
        }
    }
    
    fileprivate func makeNotificationModel(userInfo: [AnyHashable: Any]?) ->NotificationViewModel {
        let notificationModel = NotificationViewModel()
        notificationModel.body = userInfo?["body"] as? String
        notificationModel.title = userInfo?["title"] as? String
        notificationModel.slug = userInfo?["slug"] as? String
        return notificationModel
    }
}

extension FCMNotificationService{
    
    fileprivate func displayNotificationInForeground(notificationModel : NotificationViewModel?, completion: (() -> Void)? = nil){
        if let notificationModel = notificationModel{
            var config = SwiftMessages.Config()
            config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
            config.duration = .seconds(seconds: 9)
            let view: MessageView = try! SwiftMessages.viewFromNib(named: "NotificationView")
            view.configureTheme(Theme.info)
            view.configureDropShadow()
            view.bodyLabel?.text = notificationModel.title
            view.titleLabel?.text = notificationModel.body
//            view.bodyLabel?.attributedText = notificationModel.title?.replaceParagraphTag()?.html2AttributedString
            view.button?.isHidden = true
//            view.titleLabel?.isHidden = true
            view.iconImageView?.layer.cornerRadius = 0
            view.iconImageView?.image = #imageLiteral(resourceName: "ic_logo")
            view.tapHandler = {
                _ in
                SwiftMessages.hide()
                completion?()
            }
            SwiftMessages.show(config: config, view: view)
        }
    }
}
