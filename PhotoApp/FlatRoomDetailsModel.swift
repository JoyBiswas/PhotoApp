//
//  FlatRoomDetailsModel.swift
//  PhottoApp
//
//  Created by RIO on 5/7/18.
//  Copyright © 2018 RIO. All rights reserved.
//

import Foundation


struct RoomCategories {
    
    var categoryImageName:String
    var title:String
    var categoryImage:[String]

    
}

class RoomLibrary {
    
    class func fetchPhotos()->[RoomCategories] {
        
        
        var categories = [RoomCategories]()
        
        let photosData = RoomLibrary.downloadImageData()
        
        for (categoryTitle,dict) in photosData {
            
            if let dict = dict as? [String:Any] {
                
                let categoryImageName = dict["categoryImageName"] as! String
                
                if let categoryImage = dict["categoryImage"] as? [String] {
                    
                   
                    
                    let newCategory = RoomCategories(categoryImageName: categoryImageName, title: categoryTitle, categoryImage: categoryImage)
                    
                    categories.append(newCategory)
                    
                    
                    
                }
                
                
            }
        }
        
        return categories
    }
    
    class func downloadImageData()->[String:Any] {
        
        return [
            
            "Bed-Room" : [
                
                "categoryImageName":"bed room",
                "categoryImage":RoomLibrary.categoryimages(categoryPrefix: "bed", numberOfImages:5 ),
                
            ],
            "Daining-Room" : [
                
                "categoryImageName":"daining room",
                "categoryImage":RoomLibrary.categoryimages(categoryPrefix: "d", numberOfImages: 5),
            ],
            
            "Kitchen-Room" : [
                
                "categoryImageName":"kitchen room",
                "categoryImage":RoomLibrary.categoryimages(categoryPrefix: "k", numberOfImages: 5),
                
            ],
            "Balcony" : [
                
                "categoryImageName":"balcony room",
                "categoryImage":RoomLibrary.categoryimages(categoryPrefix: "b", numberOfImages: 5),
                
            ],
            
            
        ]
        
    }
    
    private class func categoryimages(categoryPrefix:String,numberOfImages:Int)-> [String] {
        
        var imageName=[String]()
        
        for i in 1...numberOfImages {
            
            imageName.append("\(categoryPrefix)\(i)")
        }
        
        return imageName
        
    }
    
    
    
    
   
    
    
}
