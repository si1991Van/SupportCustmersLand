//
//  UpdateInformationViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/11/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class UpdateInformationViewController: BaseViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtFullName: RoundTextField!
    @IBOutlet weak var txtEmail: RoundTextField!
    @IBOutlet weak var txtBirthday: RoundTextField!
    var vm = UpdateProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        avatar.setCornerRadius()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func updateView(){
        txtFullName.text = UserService.userInfo?.fullname
        txtEmail.text = UserService.userInfo?.email
        txtBirthday.text = UserService.userInfo?.birthday
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        view.endEditing(true)
        vm.fullName = txtFullName.text
        vm.email = txtEmail.text
        vm.birthday = txtBirthday.text
            DgmWaiting.sharedInstance().show()
        
            vm.updateProfile(onSuccess: {message in
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
    
    @IBAction func onClickProfiel(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appDelegate.goToProfile()
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
