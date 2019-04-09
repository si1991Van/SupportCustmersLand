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
        tabPhone?.getDataPhone(phone: respon?.hotline, email: respon?.email, id: respon?.id, urlLogo: respon?.image_url, rating: respon?.rank_project, title: respon?.name)
        
        let tabHistory = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController
        tabHistory?.viewHistory(id: respon?.id)
        
        let tabNewsPager = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        tabNewsPager?.viewTabinfoId(projectId: respon?.id)
        
        let tabUser = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController
        
        tabUser?.viewTabUserProjectId(id: respon?.id)
        
        let tabManager = storyboard.instantiateViewController(withIdentifier: "ManageViewController")
//        tabManager.tabBarItem.title = Loc("profile_screen_tab_title")
        
        viewControllers = [
            tabPhone!,
            tabHistory!,
            tabNewsPager!,
            tabUser!,
            tabManager
        ]
    }
}
extension TabBarController{
    func getData(response: ProjectItemResponse?){
        self.respon = response
    }
}
