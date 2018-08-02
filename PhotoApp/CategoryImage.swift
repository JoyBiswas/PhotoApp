//
//  CategoryImage.swift
//  PhotoApp
//
//  Created by RIO on 6/11/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import Foundation

class CategoryImage {
    
    
    private var _photoImage:String!
    private var _catagoryName:String!
    
    
    var photo:String {
        
        return _photoImage
        
    }
    var catagoryName:String {
        
        return _catagoryName
    }
    
    
    init(flatPhoto:String,catagoryName:String) {
        
        self._photoImage = flatPhoto
        self._catagoryName = catagoryName
    }
}
