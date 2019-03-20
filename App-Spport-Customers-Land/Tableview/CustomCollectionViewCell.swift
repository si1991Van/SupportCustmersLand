//
//  CustomCollectionViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue
            {
                self.titleLabel.textColor = UIColor.hex("#f48120")
//                self.blueDividerLineImageView.isHidden = false
            }
            else
            {
                self.titleLabel.textColor = UIColor.black
//                self.blueDividerLineImageView.isHidden = true
            }
        }
    }
    
    //MARK: Internal Properties
    var titleString : String?{
        get{
            return self.titleLabel.text
        }
        set{
            self.titleLabel.text = newValue
        }
    }
    
    //MARK: View Lifecycle Methods
    override func awakeFromNib()
    {
        self.titleLabel.text = nil
        
        
    }
}
