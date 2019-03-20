//
//  DetailNewsViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import WebKit

class DetailNewsViewController: BaseViewController {
    static let NEW_NOTIFICATION = "NEW_NOTIFICATION"
    @IBOutlet weak var avatatr: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var newsWebView: WKWebView!
    var link: String?
    var txtTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatatr.setCornerRadius()
        avatatr.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        let myURL = URL(string: Config.URL_DETAIL_NEW + link!)
        let myRequest = URLRequest(url: myURL!)
        newsWebView.load(myRequest)
    }
    override func localization() {
        labTitle.text = txtTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "ProfileViewController") {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
extension DetailNewsViewController{
    func viewDetailNewsData(link: String?, title: String?){
        self.txtTitle = title
        self.link = link
    }
}

