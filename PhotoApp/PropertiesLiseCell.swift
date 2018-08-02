//
//  PropertiesLiseCell.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit


class PropertiesListCell:UITableViewCell {
    
    
    @IBOutlet weak var propertyListLbl:UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
    
}
