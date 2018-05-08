//
//  PropertiesFlatDescModel.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/7/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import Foundation
import UIKit

class PropertiesFlatDescriptionModel {
    

    
    var flatName:String!
    var flatImage:UIImage!
    var flatImageDes:String!
    
    init(name:String,image:UIImage,description:String) {
        
        self.flatName = name
        self.flatImage = image
        self.flatImageDes = description
        
        
    }
    static func createCategory()->[PropertiesFlatDescriptionModel] {
        
        return [PropertiesFlatDescriptionModel(name:"201", image: UIImage(named: "flat-201.jpg")!,description:"Front View"),
                PropertiesFlatDescriptionModel(name:"202", image: UIImage(named: "flat-202.jpg")!,description:"Drawing View"),
                PropertiesFlatDescriptionModel(name:"203", image: UIImage(named: "flat-203.jpg")!,description:"Balcony View"),
                PropertiesFlatDescriptionModel(name:"204", image: UIImage(named: "flat-204.jpg")!,description:"Front View"),
                PropertiesFlatDescriptionModel(name:"205", image: UIImage(named: "flat-205.jpg")!,description:"Rare View"),
                PropertiesFlatDescriptionModel(name:"206", image: UIImage(named: "flat-206.jpg")!,description:"Bed Room View"),
                
        ]
        
        
    }
    

}
