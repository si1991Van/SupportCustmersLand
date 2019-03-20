//
//  TabBarController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/27/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
enum Tab: Int {
    case TabPhone = 0,
    TabHistory = 1,
    TabNewPager = 2,
    TabUser = 3,
    TabManager = 4
}


class TabBarController: UITabBarController {
    var respon: ProjectItemResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let tabPhone = storyboard.instantiateViewController(withIdentifier: "SupportSwitchboardViewController") as? SupportSwitchboardViewController
        tabPhone?.getDataPhone(phone: respon?.hotline, email: respon?.email, id: respon?.id, urlLogo: respon?.image_url)
//        tabPhone?.tabBarItem.title = Loc("dashboard-tab-title")
        
        let tabHistory = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController
        tabHistory?.viewHistory(id: respon?.id)
//        tabHistory.tabBarItem.title = Loc("press-release-tab-title")
        
        let tabNewsPager = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        tabNewsPager?.viewTabinfoId(projectId: respon?.id)
//        tabNewsPager.tabBarItem.title = Loc("press-conference-tab-title")
        
        let tabUser = storyboard.instantiateViewController(withIdentifier: "UserViewController")
//        tabUser.tabBarItem.title = Loc("notification-tab-title")
        
        let tabManager = storyboard.instantiateViewController(withIdentifier: "ManageViewController")
//        tabManager.tabBarItem.title = Loc("profile_screen_tab_title")
        
        viewControllers = [
            tabPhone!,
            tabHistory!,
            tabNewsPager!,
            tabUser,
            tabManager
        ]
    }
}
extension TabBarController{
    func getData(response: ProjectItemResponse?){
        self.respon = response
    }
}
