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
    @IBOutlet weak var startingMonthField:FancyLabel!
    @IBOutlet weak var endingMonthField:FancyLabel!
    @IBOutlet weak var startingDateField:FancyLabelBottom!
    @IBOutlet weak var endingDateField:FancyLabelBottom!
    
    @IBOutlet weak var dateBGView: FancyView!
    
    
    
    
    var property:PropertyModel!
    
    
    
    func configureCell(property:PropertyModel ,img:UIImage?) {
        self.property = property
        
        print("Joy\(property.startingDate)")
        self.flatNo.text = property.propertyFlatNo
        self.flatImageDescription.text = property.propertyCategory
        self.startingMonthField.text = property.startindMonth
        self.startingDateField.text = property.startingDate
        self.endingMonthField.text = ""
        self.endingDateField.text = ""
        print(self.startingDateField.text!)
        if img != nil {
            self.flatImage.image = img
        } else {
            let ref = property.flatRoomimageUrl
            let url = URL(string: ref)
            downloadImage(url: url!)
                    
            
            
            
            
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {
                let img = UIImage(data: data)
                self.flatImage.image = img
                
                PropertiesDetailsVC.imageCache.setObject(img!, forKey: self.property.flatRoomimageUrl as NSString )
            }
        }
    }


}
