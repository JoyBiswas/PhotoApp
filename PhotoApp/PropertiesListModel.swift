//
//  PropertiesListModel.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import Foundation

class PropertiesListModel {
    
    
    var _propertiesName:String!
    
    
    var propertiesName:String {
        
        
        return _propertiesName
    }
    
    init(propertiesNaMe:String) {
        
        
        self._propertiesName = propertiesNaMe
    }
    
    
}
