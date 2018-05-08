//
//  PropertiesListVC.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class PropertiesListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var propertiesList = ["A Property","B Property","C Property","D Property","E Property"]
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return propertiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertiesListCell
        
        
        cell.propertyListLbl.text = propertiesList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toPlatVc", sender: nil)
    }
    
    
    
    
    
}
