//
//  ProfileViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/8/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: BaseViewController {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    
    @IBOutlet weak var profileTableVIew: UITableView!
    @IBOutlet weak var profileHeplTableview: UITableView!
    @IBOutlet weak var imgAvatarHeader: UIImageView!
    
    
    
    var imagePicker = UIImagePickerController()
    var vm = ProfileViewModel()
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        profileTableVIew.delegate = self
        profileTableVIew.dataSource = self
        profileHeplTableview.delegate = self
        profileHeplTableview.dataSource = self
        avatar.setCornerRadius()
        imgAvatarHeader.setCornerRadius()
        imagePicker.delegate = self
    }
    
    override func localization() {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        logout()
    }
    
    @IBAction func btnChangeAvatar(_ sender: Any) {
        self.changeAvatar()
    }
    private func updateView(){
        txtName.text = UserService.userInfo?.fullname
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        imgAvatarHeader.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
    }
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count : Int?
        switch tableView {
        case self.profileTableVIew:
            count = vm.item.count
            break
        case self.profileHeplTableview:
            count = vm.itemHepl.count
            break
        default:
            count = vm.item.count
            break
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.profileTableVIew{
            let cell = profileTableVIew.dequeueReusableCell(withIdentifier: "ProfieTableViewCell") as! ProfieTableViewCell
            let item = vm.item[indexPath.row]
            cell.labName.text = item.title
            cell.img.image = item.image
            return cell
        }else{
            let cellHepl = profileHeplTableview.dequeueReusableCell(withIdentifier: "ProfileHeplTableViewCell") as! ProfileHeplTableViewCell
            let itemHepl = vm.itemHepl[indexPath.row]
            cellHepl.labName.text = itemHepl.title
            cellHepl.img.image = itemHepl.image
            return cellHepl
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.profileTableVIew {
            switch indexPath.row {
            case 0:
                if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "UpdateInformationViewController") as? UpdateInformationViewController {
                    self.present(vc, animated: true, completion: nil)
                }
               
                break
            case 1:
                if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "ChangePasswordViewController") as? ChangePasswordViewController {
                    self.present(vc, animated: true, completion: nil)
                }
                break
            case 2 :
                if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "BookingViewController") as? BookingViewController {
                    self.present(vc, animated: true, completion: nil)
                }
                break
            case 3:
                if let vc = UIStoryboard.initViewController(storyboard: "Profile", viewController: "SettingViewController") as? SettingViewController {
                    self.present(vc, animated: true, completion: nil)
                }
                break
            default:
                Toast.error("String(indexPath.row)")
                break
            }
        }
        
        if tableView == self.profileHeplTableview {
            switch indexPath.row{
            case 0:
                shareURL()
                break
            case 1:
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id1024941703"),
                    UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.openURL(url)
                }
                break
            case 2:
                sendEmail()
                break
            case 3:
                showInfoApp()
                break
            default:
                break
            }
        }
        
    }
    
    func shareURL() {
        let URLstring =  String(format:"https://itunes.apple.com/in/app/facebook/id284882215?mt=8")
        let urlToShare = URL(string:URLstring)
        let title = "title to be shared"
        let activityViewController = UIActivityViewController(
            activityItems: [title,urlToShare!],
            applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        //so that ipads won't crash
        present(activityViewController,animated: true,completion: nil)
    }
    
}

extension ProfileViewController{
    func showInfoApp() {
        let confirm = UIAlertController(title: Loc("text_show_info_app"), message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        confirm.addAction(UIAlertAction(title: Loc("logout_action_cancel"), style: .cancel, handler: nil))
        present(confirm, animated: true, completion: nil)
    }
    func logout() {
        let confirm = UIAlertController(title: Loc("logout_text_confirmation"), message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        confirm.view.tintColor = UIColor.hex("#3b9484")
        confirm.addAction(UIAlertAction(title: Loc("logout_action_confirm"), style: .destructive, handler: {
            (action: UIAlertAction!) in
            UserService.sharedInstance.logout()
        }))
        confirm.addAction(UIAlertAction(title: Loc("logout_action_cancel"), style: .cancel, handler: nil))
        present(confirm, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func changeAvatar(){
        imagePicker.allowsEditing = true
        let confirm = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let takePhotoAction = UIAlertAction(title: Loc("user_change_avatar_by_camera"), style: .default, handler: {
            _ in
            DispatchQueue.main.async {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        
        takePhotoAction.setTextColor(textColor: UIColor.hex("#3b9484"))
        confirm.addAction(takePhotoAction)
        
        let selectPhotoAction = UIAlertAction(title: Loc("user_change_avatar_by_photo"), style: .default, handler: {
            _ in
            DispatchQueue.main.async {
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        selectPhotoAction.setTextColor(textColor: UIColor.hex("#3b9484"))
        confirm.addAction(selectPhotoAction)
        
        let cancelAction = UIAlertAction(title: Loc("user_change_avatar_cancel"), style: .cancel, handler: nil)
        cancelAction.setTextColor(textColor: UIColor.defaultTextColor)
        confirm.addAction(cancelAction)
        present(confirm, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            vm.changeAvatar(pickedImage, onSuccess: {
                avatarUrl in
                self.avatar.fromUrl(avatarUrl!)
                DgmWaiting.sharedInstance().dismiss()
                Toast.success(Loc("user_change_avatar_successful"))
            }, onError: {
                errorMessage in
                DgmWaiting.sharedInstance().dismiss()
                Toast.error(errorMessage)
            })
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

