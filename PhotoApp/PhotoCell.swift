//
//  PhotoCell.swift
//  PhotoMAniac
//
//  Created by JOY BISWAS on 5/2/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class PhotoCell:UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var cameraBtnImg: UIImageView!
    
     var property:PropertyModel!
    func configureCell(img:String?) {
      
        if img != nil {
            let ref = img
            let url = URL(string: ref!)
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
                self.photoImageView.image = img
                
              
            }
        }
    }
    
}
