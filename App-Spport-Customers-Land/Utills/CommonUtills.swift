//
//  CommonUtills.swift
//  App-Spport-Customers-Land
//
//  Created by apple on 2/27/19.
//  Copyright © 2019 haiphat. All rights reserved.
//

import Foundation
import UIKit

class CommonUtills{

    let datePicker = UIDatePicker()
    
    func showDatePicker(txtDatePicker: UITextField){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
    
    }

    @objc func donedatePicker(txtDatePicker: UITextField){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        
    }

    @objc func cancelDatePicker(){
    }
}

