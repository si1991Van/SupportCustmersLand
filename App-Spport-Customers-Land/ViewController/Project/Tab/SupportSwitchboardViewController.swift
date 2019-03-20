//
//  SupportSwitchboardViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class SupportSwitchboardViewController: BaseViewController {

    @IBOutlet weak var buttHotlline: UIButton!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgaLogo: UIImageView!
    var phone: String?
    var email: String?
    var link : String?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        buttHotlline.setTitle("Hotline: " + phone!, for: .normal)
        buttonEmail.setTitle("Email: " + email! , for: .normal)
        imgaLogo.fromUrl(link, placeholder: #imageLiteral(resourceName: "ic_logo"))
        imgaLogo.setBorderCornerRadius()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToProfile()
        }
    }
    @IBAction func onClickBack(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToMain()
        }
    }
    @IBAction func onClickPhone(_ sender: Any) {
        dialNumber(number: phone)
        
    }
    @IBAction func onClickChat(_ sender: Any) {
        if let vc = UIStoryboard.initViewController(storyboard: "Home", viewController: "ChatFirebaseViewController") as? ChatFirebaseViewController {
            self.present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func onClickSendEmail(_ sender: Any) {
        sendEmail()
    }
    
    
    func dialNumber(number : String?) {
        
        if let url = URL(string: "tel://\(String(describing: number))"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            Toast.error("Có lỗi xảy ra")
        }
    }
}
extension SupportSwitchboardViewController{
    func getDataPhone(phone: String?, email: String?, id: Int?, urlLogo: String?){
        self.phone = phone ?? "Đang cập nhật"
        self.email = email ?? "Đang cập nhật"
        self.id = id
        self.link = urlLogo ?? ""
    }
}

