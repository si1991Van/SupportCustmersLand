//
//  ProfieTableViewCell.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/10/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import UIKit

class ProfieTableViewCell: UITableViewCell {
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
