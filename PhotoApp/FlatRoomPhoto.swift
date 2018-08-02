//
//  FlatRoomPhoto.swift
//  PhotoApp
//
//  Created by RIO on 5/30/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit


class FlatRoomPhoto {
    
    private var _photoImage:UIImage!
    
    
    var photo:UIImage {
        
        return _photoImage ?? #imageLiteral(resourceName: "flat-205.jpg")
    }
   
    
    init(flatPhoto:UIImage) {
        
        self._photoImage = flatPhoto
    }
}
