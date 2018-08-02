//
//  PhotoListModel.swift
//  PhotoApp
//
//  Created by RIO on 6/24/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class PicListModel {
    
//    {
//    "pic_id":1,
//    　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　    　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　    "koumoku_id":1,
//    "koumoku_name":"共通事項",
//    "sekou_status":1,
//    "bunrui_dai_id":1,
//    "bunrui_dai_name":"内装工事",
//    "bunrui_tyu_id":1,
//    "bunrui_tyu_name":"スタンダード",
//    "bunrui_syo_id":1,
//    "bunrui_syo_name":"共通",
//    "pic_path":"http://imprest.sakura.ne.jp/buils/uplord/abcdefg.jpg",
//    "thum_data":"/iq47/daed/dtee/…"
//    "pic_comment":"写真のコメント"
//    },
    
    private var _pic_id:Int!
    private var _koumoku_name:String!
    private var _sekou_status:Int!
    private var _punrui_dai_id:Int!
    private var _bunrui_dai_name:String!
    private var _bunrui_tyu_id:Int!
    private var _bunrui_tyu_name:String!
    private var _bunrui_syo_id:Int!
    private var _bunrui_syo_name:String!
    private var _thum_data:UIImage!
    private var _pic_comment:String!
    
    
    var pic_id:Int {
        
        return _pic_id
    }
    var koumoku_name:String {
        
       return _koumoku_name
    }
    var sekou_status:Int {
        
        return _sekou_status
    }
    var punrui_dai_id:Int {
        
        return _punrui_dai_id
    }
    var bunrui_dai_name:String {
        return _bunrui_dai_name
    }
    var bunrui_tyu_id:Int {
        
        return _bunrui_tyu_id
    }
    
    var bunrui_tyu_name:String {
        
        return  _bunrui_tyu_name
    }
    var bunrui_syo_id:Int {
        
        return _bunrui_syo_id
    }
    var bunrui_syo_name:String {
        
        return _bunrui_syo_name
    }
    var thum_data:UIImage {
        
        return  _thum_data ?? #imageLiteral(resourceName: "flat-201.jpg")
    }
    var pic_comment:String {
        
        return  _pic_comment
    }
    
    init(pic_id:Int,koumoku_name:String,sekou_status:Int,bunrui_dai_name:String,bunrui_tyu_id:Int,bunrui_tyu_name:String,bunrui_syo_id:Int,bunrui_syo_name:String,thum_data:UIImage,pic_comment:String ) {
        self._pic_id = pic_id
        self._koumoku_name = koumoku_name
        self._sekou_status = sekou_status
        self._bunrui_dai_name = bunrui_dai_name
        self._bunrui_tyu_id = bunrui_tyu_id
        self._bunrui_tyu_name = bunrui_tyu_name
        self._bunrui_syo_id = bunrui_syo_id
        self._bunrui_syo_name = bunrui_syo_name
        self._thum_data = thum_data
        self._pic_comment = pic_comment
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
