//
//  AppDelegate.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 12/29/18.
//  Copyright © 2018 haiphat. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var enableLandscape: Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.initialPushNotification(application)
        self.openMainScreenIfValid(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if (enableLandscape == true){
            return .landscapeRight
        }
        return .portrait
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        FCMNotificationService.sharedInstance.receiveActionForNotification(application: application, userInfo: userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        FCMNotificationService.sharedInstance.receiveActionForNotification(application: application, userInfo: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
    }
}

extension AppDelegate{
    func openMainScreenIfValid(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        if(UserService.sharedInstance.isLoggedIn){
                goToMain()
        } else {
            self.goToLogin()
        }
    }
    
    func goToLogin() {
        if let vc = UIStoryboard.initViewController(storyboard: "Main", viewController: "LoginViewController") {
            self.window?.rootViewController = vc
        }
    }
    
    func goToMain(){
        if let vc = UIStoryboard.initViewController(storyboard: "Home", viewController: "ProjectController") {
            self.window?.rootViewController = vc
        }
    }
    
    func goToProfile() {
        if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "ProfileViewController") {
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func goToDetailProject(response: ProjectItemResponse?){
        if let vc = UIStoryboard.initViewController(storyboard: "Home", viewController: "TabBarController") as? TabBarController{
            guard let snapshot = self.window?.snapshotView(afterScreenUpdates: true) else {
                self.window?.rootViewController = vc
                return
            }
            vc.getData(response: response)
            vc.view.addSubview(snapshot)
            self.window?.rootViewController = vc
            snapshot.removeFromSuperview()
        }
    }
    
    func changePassword() {
        if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "ChangePasswordViewController") as? ChangePasswordViewController {
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func updateProfile() {
        if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "UpdateInformationViewController") as? UpdateInformationViewController {
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func setting() {
        if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "SettingViewController") as? SettingViewController {
            self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func handlePushNotification(_ notificationViewModel: NotificationViewModel) {
        if UserService.sharedInstance.isLoggedIn {
            if let vc = UIStoryboard.initViewController(storyboard: "Home", viewController: "DetailNewsViewController") as? DetailNewsViewController {
                vc.viewDetailNewsData(link: notificationViewModel.slug, title: notificationViewModel.title)
                self.window?.rootViewController?.present(vc, animated: true, completion: nil)
            }
            
        }
    }
}
extension AppDelegate : MessagingDelegate{
    fileprivate func initialPushNotification(_ application: UIApplication){
        FirebaseApp.configure()
        self.updateFCMToken()
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
//        NotificationCenter.default.post(name: NSNotification.Name(TabBarController.GET_TOTAL_UNSEEN_NOTIFICATION), object: nil)
    }
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        FCMNotificationService.sharedInstance.token = fcmToken
    }
    // [END refresh_token]
    
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
    
    
    
    func updateFCMToken(){
        if let fcmToken = Messaging.messaging().fcmToken {
            FCMNotificationService.sharedInstance.token = fcmToken
        }    
    }

}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        FCMNotificationService.sharedInstance.receivedNotificationInForeground(userInfo: notification.request.content.userInfo)
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        FCMNotificationService.sharedInstance.receivedNotificationInBackground(userInfo: response.notification.request.content.userInfo)
        completionHandler()
    }
}



