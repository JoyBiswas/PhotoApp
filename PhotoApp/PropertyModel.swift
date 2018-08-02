//
//  PropertyModel.swift
//  PhotoApp
//
//  Created by RIO on 5/15/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import Foundation
import UIKit

class PropertyModel {
    
    
    //[{"pid":"1","procat":"Properties A","flatno":"201","roomname":"Drawing Room","picture":"pic1.jpg"}]
    private var _propertyid: String!
    private var _flatRoomimageUrl: String!
    private var _propertyCategory: String!
    private var _propertyFlatNo:String!
    private var _flatRoomName:String!
    private var _uiimage:UIImage?
    private var _startindMonth:String!
    private var _endingMonth:String!
    private var _startingDate:String!
    private var _endindDate:String!
    
    
    private var _productDescription:String!
    private var _productKey: String!
    private var _pricePerQuantity:String!
    
    
    var propertyid: String {
        
        return _propertyid
        
    }
    var propertyCategory: String {
        
        return _propertyCategory
        
    }
    
    var flatRoomimageUrl: String {
        return _flatRoomimageUrl
    }
    
    var propertyFlatNo: String {
        return _propertyFlatNo
    }
    
    var flatRoomName: String {
        
        return _flatRoomName
    }
    var uiimage:UIImage {
        
        return _uiimage ?? #imageLiteral(resourceName: "flat-205.jpg")
        
    }
    var startindMonth:String {
        
        return _startindMonth
    }
    
    var startingDate:String {
        
        return _startingDate 
    }
    
    
    init(propertyid: String, flatRoomimageUrl: String, propertyCategory:String, propertyFlatNo:String, flatRoomName:String,uiimage:UIImage?,startindMonth:String,startingDate:String){
        
        self._propertyid = propertyid
        self._propertyCategory = propertyCategory
        self._propertyFlatNo = propertyFlatNo
        self._flatRoomimageUrl = flatRoomimageUrl
        self._flatRoomName = flatRoomName
        self._uiimage = uiimage
        self._startindMonth = startindMonth
        self._startingDate = startingDate
       
    }
    

    
    
}
