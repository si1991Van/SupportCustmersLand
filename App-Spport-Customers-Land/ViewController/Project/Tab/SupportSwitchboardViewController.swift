//
//  SupportSwitchboardViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import Cosmos
class SupportSwitchboardViewController: BaseViewController {

    @IBOutlet weak var buttHotlline: UIButton!
    @IBOutlet weak var buttonEmail: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgaLogo: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    private var vm = SupportViewMode()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        buttHotlline.setTitle("Hotline: " + vm.phone!, for: .normal)
        buttonEmail.setTitle("Email: " + vm.email! , for: .normal)
        imgaLogo.fromUrl(vm.link, placeholder: #imageLiteral(resourceName: "ic_logo"))
        imgaLogo.setBorderCornerRadius()
        txtTitle.text = vm.title
        ratingView.rating = Double(vm.rating ?? 0)
        ratingView.didFinishTouchingCosmos = { rating in
            
            self.postRatingProject(rating: rating)
        }
        
        // Do any additional setup after loading the view.
    }
    
    private func postRatingProject(rating : Double?){
        DgmWaiting.sharedInstance().show()
        vm.postRattingProject(onSuccess: {message in
            DgmWaiting.sharedInstance().dismiss()
            Toast.error(message)
        }, onFail: { errorMessage in
            DgmWaiting.sharedInstance().dismiss()
            Toast.error(errorMessage)
            
        })
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
        dialNumber(number: vm.phone)
        
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
        if let urlMobile = NSURL(string: "tel://"+number!),
            UIApplication.shared.canOpenURL(urlMobile as URL) {
            UIApplication.shared.open(urlMobile as URL)
        }else {
                Toast.error("Có lỗi xảy ra")
        }
    }
}
extension SupportSwitchboardViewController{
    func getDataPhone(phone: String?, email: String?, id: Int?, urlLogo: String?, rating : Int?, title: String?){
        self.vm.phone = phone ?? "Đang cập nhật"
        self.vm.email = email ?? "Đang cập nhật"
        self.vm.id = id
        self.vm.link = urlLogo ?? ""
        self.vm.rating = rating
        self.vm.title = title
    }
    
    
}

