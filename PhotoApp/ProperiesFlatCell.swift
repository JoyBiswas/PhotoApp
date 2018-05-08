//
//  ProperiesFlatCell.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/7/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit


class PropertiesFlatCell:UICollectionViewCell {
    
    @IBOutlet weak var flatNo:UILabel!
    @IBOutlet weak var flatImage:UIImageView!
    @IBOutlet weak var flatImageDescription:UILabel!
    
    
    var myflatDesc:PropertiesFlatDescriptionModel! {
        
        didSet {
            
            updateData()
        }
        
    }
    
    
    func updateData() {
        
        
        flatNo.text = myflatDesc.flatName
        flatImage.image = myflatDesc.flatImage
        flatImageDescription.text = myflatDesc.flatImageDes
        
    }
    
   

}
