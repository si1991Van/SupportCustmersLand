//
//  InfoViewController.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/14/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import RatingBar
//import CarbonKit

class InfoViewController: BaseViewController {

    @IBOutlet weak var HeaderCollectionView: UICollectionView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var tableViewNews: UITableView!
    var vm = TabInforViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatar.setCornerRadius()
        avatar.fromUrl(UserService.userInfo?.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
        HeaderCollectionView.delegate = self
        HeaderCollectionView.dataSource = self
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
        getCategory()
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
    
    private func getCategory(){
        vm.getCategory(onSuccess: {
            self.HeaderCollectionView.reloadData()
            self.vm.categoryId = self.vm.categoryItem[0].id
            self.vm.page = 1
            self.vm.current = 10
            self.getItemNews()
        }, onFail: {errorMessager in
            Toast.error(errorMessager)
        })
    }
}

extension InfoViewController{
    func viewTabinfoId(projectId: Int?) {
        self.vm.id = projectId
    }
}

extension InfoViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return vm.categoryItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = HeaderCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        cell.titleString = vm.categoryItem[indexPath.row].name
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        //For initially highlighting the first cell of "customCollectionView" when ViewController is loaded
        guard let _ = HeaderCollectionView.indexPathsForSelectedItems?.first, indexPath.row != 0 else
        {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        HeaderCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        vm.categoryId = vm.categoryItem[indexPath.row].id
        vm.page = 1
        vm.current = 10
        
        getItemNews()
    }
    
    private func getItemNews(){
        vm.item.removeAll()
        vm.getNewsItems(onSuccess: {
            self.tableViewNews.reloadData()
        }, onFail: {errorMessage in
            Toast.error(errorMessage)
        })
    }
    
}
extension InfoViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNews.dequeueReusableCell(withIdentifier: "TabInforTableViewCell")as! TabInforTableViewCell
        cell.labTitle.text = vm.item[indexPath.row].title
        cell.labTime.text = vm.item[indexPath.row].created_at
        cell.img.fromUrl(vm.item[indexPath.row].image_url, placeholder: #imageLiteral(resourceName: "ic_logo"))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.initViewController(storyboard: "Home", viewController: "DetailNewsViewController") as? DetailNewsViewController {
            vc.viewDetailNewsData(link: vm.item[indexPath.row].slug, title: vm.item[indexPath.row].title)
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
}


