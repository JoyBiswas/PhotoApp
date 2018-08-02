//
//  CustomeSegment.swift
//  PhotoApp
//
//  Created by RIO on 6/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class CustomeSegment: UISegmentedControl {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let red = UIColor(red: 207.0/255.0, green: 212.0/255.0, blue: 201.0/255.0, alpha: 1)
        layer.borderColor = red.cgColor
 
        let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        layer.borderWidth = 1.0
    }
    override func widthForSegment(at segment: Int) -> CGFloat {
        return 10.0
    }
}
