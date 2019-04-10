//
//  SaleCollectionViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit
import Cosmos

class SaleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labRating: UILabel!
    @IBOutlet weak var cosmosView: CosmosView!
    var saleId : Int?
    var transactionId : Int?
    var rating : Double = 0.0
    
    var vm : SaleResponse? {
        didSet {
            updateView()
            
        }
    }
    
    func updateView() {
        if let vm = self.vm{
            let title = "Hỗ trợ giao dịch" + vm.name! + "-" + vm.project_name!
            let rating = vm.rank
            self.imgAvatar.fromUrl(vm.avatar, placeholder: #imageLiteral(resourceName: "ic_avatar_default"))
            self.labName.text = vm.fullname
            self.labTitle.text = title
            self.labRating.text = "Đánh giá nhân viên kinh doanh"
            self.cosmosView.rating = Double(rating ?? 0)
            self.saleId = vm.id
            self.transactionId = vm.transaction_id
            self.cosmosView.didTouchCosmos = { rating in
                self.rating = rating
            }
        }
    }
}
