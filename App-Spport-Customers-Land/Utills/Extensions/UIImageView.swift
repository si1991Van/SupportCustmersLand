//
//  UIImageView.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 1/22/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    func fromUrl(_ urlString: String?,  placeholder: UIImage? = nil) {
        if let url = urlString, let _url = URL(string: url) {
            self.kf.setImage(with: _url,placeholder: placeholder)
        } else {
            self.image = placeholder
        }
    }
    func setCornerRadius()  {
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
    }
    
    func setBorderCornerRadius() {
        self.layer.cornerRadius = self.bounds.size.width / 12
        self.clipsToBounds = true
    }
}
