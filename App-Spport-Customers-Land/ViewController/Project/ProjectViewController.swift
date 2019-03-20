//
//  ProjectViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/8/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtProjectHeader: UILabel!
    @IBOutlet weak var projectCollectionView: UICollectionView!
    var vm = ProjectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        vm.getItem(onSuccess: {
            self.projectCollectionView.reloadData()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickProfile(_ sender: Any) {
        if let appdelegate  = UIApplication.shared.delegate as? AppDelegate{
            appdelegate.goToProfile()
        }
    }
    
}

extension ProjectViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.projectResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = projectCollectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCollectionViewCell", for: indexPath) as! ProjectCollectionViewCell
        cell.img.fromUrl(vm.projectResponse[indexPath.row].image_url, placeholder: #imageLiteral(resourceName: "ic_logo"))
        cell.img.setBorderCornerRadius()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate{
            appdelegate.goToDetailProject(response: vm.projectResponse[indexPath.row])
        }
        
    }
    
}
