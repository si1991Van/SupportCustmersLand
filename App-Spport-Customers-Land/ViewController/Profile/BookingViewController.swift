//
//  BookingViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/26/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class BookingViewController: BaseViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    var vm = BookingViewModel()
    
    @IBOutlet weak var txtFullName: RoundTextField!
    @IBOutlet weak var txtPhone: RoundTextField!
    @IBOutlet weak var txtEmail: RoundTextField!
    @IBOutlet weak var txtDay: RoundTextField!
    @IBOutlet weak var txtTime: RoundTextField!
    @IBOutlet weak var txtNote: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        if UserService.userInfo != nil{
            txtFullName.text = UserService.userInfo?.fullname
            txtPhone.text = UserService.userInfo?.phone
            txtEmail.text = UserService.userInfo?.email
        }
        
    }
    override func localization() {
        
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToProfile()
        }
        
    }
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBooking(_ sender: Any) {
        postBooking()
    }
    
    
    
    private func postBooking(){
        vm.fullName = txtFullName.text
        vm.phone = txtPhone.text
        vm.email = txtEmail.text
        vm.timeView = String(describing: txtDay.text) + String(describing: txtTime.text)
        vm.note = txtFullName.text
        
        DgmWaiting.sharedInstance().show()
        vm.postBooking(onSuccess: {message in
                DgmWaiting.sharedInstance().dismiss()
                DgmAlert.success(title: Loc("alert-title-success"),
                                 text: message)?.setDismissBlock {
                                    self.dismiss(animated: true, completion: nil)
                }
        }, onFail: {errorMessage in
            DgmWaiting.sharedInstance().dismiss()
            Toast.error(errorMessage)
        })
    }
    

}
