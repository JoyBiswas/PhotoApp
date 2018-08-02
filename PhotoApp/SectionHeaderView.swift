//
//  SectionHeaderView.swift
//  PhotoMAniac
//
//  Created by JOY BISWAS on 5/2/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class SectionHeaderView:UICollectionReusableView {
    
    
    @IBOutlet weak var sectionTitleLabel:UILabel!
    @IBOutlet weak var sectionImg:UIImageView!
    
    
    var photocategory:PropertyModel! {
        
        
        didSet {
            
            sectionTitleLabel.text = photocategory.propertyCategory
            sectionImg.image = photocategory.uiimage
        }
    }
}
