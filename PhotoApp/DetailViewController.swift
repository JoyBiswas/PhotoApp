//
//  DetailViewController.swift
//  PhotoMAniac
//
//  Created by JOY BISWAS on 5/2/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var categoryImage:UIImageView!
    
    var image:UIImage!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryImage.image = image
        
        navigationItem.title = "Details Photo"

    }
    
    @IBOutlet weak var scrollView:UIScrollView!
   
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return categoryImage
    }
    
}



