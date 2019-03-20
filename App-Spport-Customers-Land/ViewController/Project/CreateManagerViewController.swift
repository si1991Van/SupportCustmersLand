//
//  CreateManagerViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/12/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import iOSDropDown

class CreateManagerViewController: BaseViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var dropProductType: DropDown!
    @IBOutlet weak var dropLandType: DropDown!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var dropCity: DropDown!
    @IBOutlet weak var dropDistrict: DropDown!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var dropAreaType: DropDown!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var dropPriceType: DropDown!
    
    @IBOutlet weak var txtDiscription: UITextField!
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imagUpload: UIImageView!
    
    @IBOutlet weak var tabViewUploadImage: UICollectionView!
    var imagePicker = UIImagePickerController()
    var vm = CreateManagerViewModel()
    var list : [LinkResponse] = []
    var arrayUrl : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        tabViewUploadImage.delegate = self
        imagUpload.image = #imageLiteral(resourceName: "ic-setting")
        tabViewUploadImage.dataSource = self
        imagePicker.delegate = self
        getOption()
    }

    override func localization() {
        self.labTitle.text = Loc("Quản lý ký gửi")
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
    
    @IBAction func onClickSave(_ sender: Any) {
        if self.vm.typeUpdate == 111{
            self.updateManager()
        }else{
            addManager()
        }
    }
    
    @IBAction func onClickUploadImage(_ sender: Any) {
        changeAvatar()
    }
    
    private func getOption(){
        vm.getOption(onSuccess: {
            self.showDropProduct(dropDow: self.dropProductType ,list: self.vm.optionResponse.product_type)
            self.showDropCity(dropDow: self.dropCity ,list: self.vm.optionResponse.city)
            self.showDrop(dropDow: self.dropAreaType ,list: self.vm.optionResponse.area)
            self.showDrop(dropDow: self.dropPriceType ,list: self.vm.optionResponse.price_type)
            
            self.updateViewManager()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }
}
extension CreateManagerViewController{
    
    func showDrop(dropDow: DropDown, list : [BaseOption]?){
        var item = [String]()
        var itemId = [Int]()
        list?.forEach { it in
            item.append(it.name!)
            itemId.append(it.id!)
        }
        dropDow.optionArray = item
        dropDow.optionIds = itemId
        dropDow.isSearchEnable = true
        
        dropDow.didSelect{(selectedText , index , id) in
            dropDow.text = selectedText
            switch(list![index].type){
                case 2?:
                    self.vm.land_type = list![index].id
                    break
                case 3?:
                    self.vm.area_type = list![index].id
                    break
                case 4?:
                    self.vm.price_type =  list![index].id
                    break
                default :
                    self.vm.district_id = list![index].id
                    break
            }
        }
    }
    
    func showDropProduct(dropDow: DropDown, list : [ProductResponse]?){
        var item = [String]()
        var itemId = [Int] ()
        list?.forEach { it in
            item.append(it.name!)
            itemId.append(it.id!)
        }
        dropDow.optionArray = item
        dropDow.optionIds = itemId
        dropDow.isSearchEnable = true
        dropDow.didSelect{(selectedText , index , id) in
            dropDow.text = selectedText
            self.vm.product_type = list![index].id
            self.showDrop(dropDow: self.dropLandType, list: self.vm.optionResponse.product_type?[index].children)
            
        }
    }
    
    func showDropCity(dropDow: DropDown, list : [CityResponse]?){
        var item = [String]()
        var itemId = [Int] ()
        list?.forEach { it in
            item.append(it.name!)
            itemId.append(it.id!)
        }
        dropDow.optionArray = item
        dropDow.optionIds = itemId
        dropDow.isSearchEnable = true
        dropDow.didSelect{(selectedText , index , id) in
            dropDow.text = selectedText
            self.vm.city_id = list![index].id
            self.showDrop(dropDow: self.dropDistrict, list: self.vm.optionResponse.city?[index].district)
            
        }
    }
    
}
extension CreateManagerViewController{
    
    func addManager(){
        self.updateText()
        DgmWaiting.sharedInstance().show()
        vm.addManager(onSuccess: {message in
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
    
    func updateManager(){
        
        self.updateText()
        DgmWaiting.sharedInstance().show()
        self.vm.updateManager(onSuccess: {message in
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
    
    
    private func updateText() {
        self.vm.fullname = txtFullName.text
        self.vm.email = txtEmail.text
        self.vm.phone = txtPhone.text
        self.vm.title = txtTitle.text
        self.vm.address = txtAddress.text
        self.vm.area = txtArea.text
        self.vm.price = txtPrice.text
        self.vm.content = txtDiscription.text
        self.list.forEach { it in
            self.arrayUrl.append(it.url!)
        }
        self.vm.images = arrayUrl.joined(separator: ",")
    }
}
extension CreateManagerViewController {
    
    func viewPushDataManager(managerResponse: ManagerResponse?, type: Int?){
        self.vm.managerResponse = managerResponse
        self.vm.typeUpdate = type
        self.vm.id = managerResponse?.id
    }
    
    func updateViewManager() {
        
        if self.vm.typeUpdate == 111 {
            self.txtFullName.text = self.vm.managerResponse?.fullname
            self.txtPhone.text = self.vm.managerResponse?.phone
            self.txtEmail.text = self.vm.managerResponse?.email
            self.txtTitle.text = self.vm.managerResponse?.title
            self.txtAddress.text = self.vm.managerResponse?.address
            self.txtArea.text = String(describing: self.vm.managerResponse?.area as! Float)
            self.txtPrice.text = String(describing: self.vm.managerResponse?.price as! Float)
            self.txtDiscription.text = self.vm.managerResponse?.discription
            
            self.vm.product_type = self.vm.managerResponse?.product_type
            self.vm.land_type = self.vm.managerResponse?.land_type
            self.vm.city_id = self.vm.managerResponse?.city_id
            self.vm.district_id = self.vm.managerResponse?.district_id
            self.vm.area_type = self.vm.managerResponse?.area_type
            self.vm.price_type = self.vm.managerResponse?.price_type
            
            pushUrl(managerResponse: self.vm.managerResponse)
            
            setValueUpdateDropDown(dropDow: self.dropPriceType, list: self.vm.optionResponse.price_type, id: self.vm.managerResponse?.price_type)
            setValueUpdateDropDown(dropDow: self.dropAreaType, list: self.vm.optionResponse.area, id: self.vm.managerResponse?.area_type)
            
            setValueUpdateDropDownProduct(dropDow: self.dropProductType, list: self.vm.optionResponse.product_type, id: self.vm.managerResponse?.product_type, landType: self.vm.managerResponse?.land_type)
            
            setValueUpdateDropDownCity(dropDow: self.dropCity, list: self.vm.optionResponse.city, id: self.vm.managerResponse?.city_id, districtId: self.vm.managerResponse?.district_id)
            
        }else{
            self.txtFullName.text = UserService.userInfo?.fullname
            self.txtPhone.text = UserService.userInfo?.phone
            self.txtEmail.text = UserService.userInfo?.email
        }
        
    }
    
    private func pushUrl(managerResponse: ManagerResponse?){
        let url = managerResponse?.images?.split(separator: ",")
        
        for name in url!{
            list.append(LinkResponse(url: String(name)))
        }
        self.tabViewUploadImage.reloadData()
    }
    
    private func setValueUpdateDropDown(dropDow: DropDown?, list: [BaseOption]?, id: Int?) {
        list?.forEach { it in
            if id == it.id {
                dropDow?.text = it.name
                
            }
        }
    }
    
    private func setValueUpdateDropDownProduct(dropDow: DropDown?, list: [ProductResponse]?, id: Int?, landType: Int?) {
        list?.forEach { it in
            if id == it.id {
                dropDow?.text = it.name
                
                self.setValueUpdateDropDown(dropDow: self.dropLandType, list: it.children, id: landType)
            }
        }
    }
    
    private func setValueUpdateDropDownCity(dropDow: DropDown?, list: [CityResponse]?, id: Int?, districtId: Int?) {
        list?.forEach { it in
            if id == it.id {
                dropDow?.text = it.name
                self.setValueUpdateDropDown(dropDow: self.dropDistrict, list: it.district, id: districtId)
            }
        }
    }
}

extension CreateManagerViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.tabViewUploadImage.dequeueReusableCell(withReuseIdentifier: "UploadImageCollectionViewCell", for: indexPath) as! UploadImageCollectionViewCell
        cell.img.fromUrl(list[indexPath.row].url, placeholder: #imageLiteral(resourceName: "ic_logo"))
        cell.iconDelete.setImage(#imageLiteral(resourceName: "ic_delete"), for: .normal)
        cell.iconDelete.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAlterDeleteImage(position: indexPath.row)


    }
    
    func showAlterDeleteImage(position: Int?){
        let confirm = UIAlertController(title: "Bạn có thực sự muốn xoá không", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        confirm.view.tintColor = UIColor.hex("#3b9484")
        
        confirm.addAction(UIAlertAction(title: "Xoá", style: .destructive, handler: {
            (action: UIAlertAction!) in
            self.list.remove(at: position!)
            self.tabViewUploadImage.reloadData()
            
        }))
        confirm.addAction(UIAlertAction(title: Loc("logout_action_cancel"), style: .cancel, handler: nil))
        self.present(confirm, animated: true, completion: nil)
    }
    
    
}

extension CreateManagerViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
            vm.updateImage(pickedImage, onSuccess: {
                self.list.append(self.vm.itemUrl!)
                self.tabViewUploadImage.reloadData()
                DgmWaiting.sharedInstance().dismiss()
            }, onFail: {
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


