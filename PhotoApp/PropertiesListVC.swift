//
//  PropertiesListVC.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class PropertiesListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    
    
    var propertyDetails=[PropertyModel]()
    
    var selectedIndexPath: NSIndexPath = NSIndexPath()
    let urlPath: String = "http://tigersoftbd.com/photos.php"
    let newurl:String = "http://tigersoftbd.com/response.php"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        [{"pid":"1","procat":"Properties A","flatno":"201","roomname":"Drawing Room","picture":"pic1.jpg","date":"2018-06-05"},{"pid":"2","procat":"Properties B","flatno":"202","roomname":"Kitchen Room","picture":"pic1.jpg","date":"2018-06-04"}]
        
//        let dict = ["pid":"3","procat":"Properties 3","flatno":"301","roomname":"Drawing Room","picture":"pic1.jpg","date":"2018-06-09"]
//            as [String: Any]
        
        //let dict = ["email":"joy","password":"12345"] as [String:Any]
        
        //create the session object
        let session = URLSession.shared
        let url = URL(string: newurl)

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url!)

        request.httpMethod = "POST"// Compose a query string

        let postString = "email=joy";

                request.httpMethod = "POST" //set http method as POST
//
////        do {
////            request.httpBody = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
////            print("JoySuccess")
////
////
////        } catch let error {
////            print(error.localizedDescription)
////            print("joyError")
////        }
        request.httpBody = postString.data(using: String.Encoding.utf8);

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {

                print(error.debugDescription)
                return
            }

            guard let data = data else {
                print("have")
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }

            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()

        
        self.downloadItems()
    }
    
    
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        
        for i in 0 ..< jsonResult.count
        {
            //            [{"pid":"1","procat":"Properties A","flatno":"201","roomname":"Drawing Room","picture":"pic1.jpg"}]
            jsonElement = jsonResult[i] as! NSDictionary 
            
            if let pid = jsonElement["pid"] as? String,
                let procat = jsonElement["procat"] as? String,
                let flatno = jsonElement["flatno"] as? String,
                let roomname = jsonElement["roomname"] as? String,
                let picture = jsonElement["picture"] as? String
            {
                print(pid,procat,flatno,roomname,picture)
                
                if picture != ""
                {
                    let photourl = "http://tigersoftbd.com/appphoto/\(picture)"
                    print(photourl)
                    
                    let property = PropertyModel(propertyid: pid, flatRoomimageUrl: photourl, propertyCategory: procat, propertyFlatNo: flatno, flatRoomName: roomname, uiimage: nil, startindMonth: "", startingDate: "")
                    self.propertyDetails.append(property)
                    
                    
                    
                    
                }
                
                
                
                
                
            }
            DispatchQueue.main.async {
                self.categoryTableView.reloadData()
            }
            
            
        }
        
        
        self.categoryTableView.reloadData()
        
        print(self.propertyDetails)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return propertyDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let propertyCategory = propertyDetails[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertiesListCell
        
        
        cell.propertyListLbl.text = propertyCategory.propertyCategory
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndexPath = indexPath as NSIndexPath
        
        performSegue(withIdentifier: "toPlatVc", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let  indexpath = self.selectedIndexPath
        if segue.identifier  == "toPlatVc" {
            
            if let vc = segue.destination as? PropertiesDetailsVC {
                
                let appartMentCall = propertyDetails[indexpath.row].propertyCategory
                
                
                vc.propatiOn = appartMentCall
            }
        }
    }
    
    
    
    
    
}
