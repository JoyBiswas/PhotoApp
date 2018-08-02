//
//  PropertiesDetailsVC.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit


class PropertiesDetailsVC:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionnView: UICollectionView!
    
    var flatImage = UIImage()
    
    
    var propatiOn:String!
    @IBOutlet weak var whichProperti:UILabel!
    @IBOutlet weak var user_name:UILabel!
    
    static var imageCache:NSCache<NSString, UIImage> = NSCache()
    
    var propertyDetails=[PropertyModel]()
    
    var selectedIndexPath: NSIndexPath = NSIndexPath()
    
    let catUrL:String =
    "http://imprest-share.sakura.ne.jp/torepo/script/get_koujilist.php"
    
    
    
//    "team_id":1,
//    "option_date":1,
//    "option_complete":1,
//    "sort_type":1,
    
    var team_id = String()
    var user_namee = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //whichProperti.text = propatiOn
        self.user_name.text = self.user_namee
       // self.downloadItems()
        

        
        let parameters = ["team_id": 1, "option_date": 1 ,"option_complete":1, "sort_type": 1] as [String : Any]
        
        //create the url with URL
        let url = URL(string: catUrL)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            let nsstr = NSString(data: data , encoding: String.Encoding.utf8.rawValue)
            print("JOUUU\(nsstr!)")
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    for (key,_) in json {
                        
                        //var valuedict = NSArray()
                        if key == "details"  {
                            let valuedict = json[key] as! [String:Any]
                                
                            print(valuedict["kouji_list"]!)
                            
                            for (key,_) in valuedict {
                                
                                if key == "kouji_list" {
                                    let realValueDict = valuedict[key] as! NSArray
                                    print(realValueDict)
                                    var jsonElement = NSDictionary()
                                    
                                    for i in 0 ..< realValueDict.count
                                    {
                                        
                                        jsonElement = realValueDict[i] as! NSDictionary
                                        print("JOYadrota \(jsonElement.allValues)")
                                        
                                        if //let pid = jsonElement["pid"] as? String,
                                            let flatNo = jsonElement["kouji_name"] as? String,
                                            let flatName = jsonElement["kouji_no"] as? String,
                                            let startingDate = jsonElement["from_date"] as? String,
                                            let endingDate = jsonElement["13"] as? String,
                                            let flatPicture = jsonElement["thum_data"] as? String
                                            
                                            
                                        {
                                            print("Its Ok",endingDate)
                                           // print(endingDate)
                                            print(flatName,flatNo,startingDate,flatPicture)
                                            let mainUrl = "http://tigersoftbd.com/appphoto/test.png"
                                            let mydateArray = startingDate.components(separatedBy: "-")
                                            
                                            let month = "\(mydateArray[0])-\(mydateArray[1])"
                                            let date = mydateArray[2]
                                            let dataDecoded : Data = Data(base64Encoded: flatPicture, options: .ignoreUnknownCharacters)!
                                            let decodedimage = UIImage(data: dataDecoded)
                                            
                                            let property = PropertyModel(propertyid: "1", flatRoomimageUrl: mainUrl, propertyCategory: flatName, propertyFlatNo: flatNo, flatRoomName: flatName, uiimage: decodedimage, startindMonth: month, startingDate: date)
                                            self.propertyDetails.append(property)
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        DispatchQueue.main.async(execute: {
                                          self.collectionnView.reloadData()
                                            
                                        })
                                       
                                        
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    // handle json...
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
    
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func downloadItems() {
        
        let url: URL = URL(string:catPath )!
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
            print("JOY\(jsonElement.allValues)")
            
            if //let pid = jsonElement["pid"] as? String,
                let picname = jsonElement["picname"] as? String,
                let flatno = jsonElement["flatno"] as? String,
                //let roomname = jsonElement["roomname"] as? String,
                let picture = jsonElement["picture"] as? String,
                let date1 = jsonElement["date"] as? String
            {
                print(flatno,picture)
                
                if picture != ""
                {
                    let photourl = "http://tigersoftbd.com/appphoto/\(picture)"
                    
                    let mydateArray = date1.components(separatedBy: "-")
                    
                    let month = "\(mydateArray[0]) \(mydateArray[1])"
                    let date = mydateArray[2]
                    print(month,date)
                    
                    let property = PropertyModel(propertyid: "1", flatRoomimageUrl: photourl, propertyCategory: picname, propertyFlatNo: flatno, flatRoomName: "j", uiimage: nil, startindMonth: month, startingDate: date)
                    self.propertyDetails.append(property)
                    
                    
                    
                    
                }
                
                
                
                
                
            }
            DispatchQueue.main.async {
                self.collectionnView.reloadData()
            }
            
            
        }
        
        
        
        
        print(self.propertyDetails)
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return propertyDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let fill = propertyDetails[indexPath.row]
        
        print(fill.startindMonth)
        print(fill.startingDate )
        
        
       // let img:UIImage!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flatCell", for: indexPath) as! PropertiesFlatCell
        
//        img = PropertiesDetailsVC.imageCache.object(forKey:propertyDetails[indexPath.row].flatRoomimageUrl as NSString)
//
//        if img != nil {
//            cell.configureCell(property: fill, img: img)
//        }else {
//            cell.configureCell(property: fill, img: nil)
//        }
        cell.flatImage.image = fill.uiimage
        cell.flatNo.text = fill.propertyFlatNo
        cell.flatImageDescription.text = fill.propertyCategory
        cell.startingDateField.text = fill.startingDate
        cell.startingMonthField.text = fill.startindMonth
        
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath as NSIndexPath
        
        
        
        performSegue(withIdentifier: "flatDesc", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexpath = self.selectedIndexPath
        let flatNo = propertyDetails[indexpath.row].propertyFlatNo
        let building = propertyDetails[indexpath.row].flatRoomName
        //let propertyCat = propertyDetails[indexpath.row].propertyCategory
        if segue.identifier == "flatDesc" {
            
            if let vc = segue.destination as? FlatRoomDetailsVC {
                
                vc.flatno = flatNo
                vc.building = building
                
                //vc.procat = propertyCat
                
            }
        }
    }
    

    
    
}

