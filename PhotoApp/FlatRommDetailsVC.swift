//
//  FlatRommDetailsVC.swift
//  PhotoApp
//
//  Created by RIO on 5/8/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit
import Alamofire

class FlatRoomDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    var imagnaMe:Int!
    var headerVieWSectionTag:Int!
    var whiceSec:Int!
    var dictionary =  [Int:String]()
    
    var procat:String!
    var flatno:String!
    var building:String!
    var roomname:String!
    var picture:String!
    
    var myImageView:UIImage!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var whichFlat:UILabel!
    
    @IBOutlet weak var runstateSegement: UISegmentedControl!
    
    
    //var roomCategory:[RoomCategories] = RoomLibrary.fetchPhotos()
    
    let picker = UIImagePickerController()
    var propertyDetails=[PropertyModel]()
    var flatPhoto = [FlatRoomPhoto]()
    
    var selectedIndexPath: NSIndexPath = NSIndexPath()
    static var imageCache:NSCache<NSString, UIImage> = NSCache()
    var pictutrId = [String]()
    let piclistUrl = "http://imprest-share.sakura.ne.jp/torepo/script/get_koumoku_piclist.php"
    
    override func viewDidLoad() {
       
        self.downloadItems(url: urlPath)
        
        whichFlat.text = "\(self.flatno!)/\(self.building!)"
        
        picker.allowsEditing = true
        picker.delegate = self
        
        let controller = UICollectionViewController()
        let collectionViewWidth = collectionView?.frame.width
        
        let itemWidth = (collectionViewWidth! - 2.0)/3.0
        
        let layOut = controller.collectionViewLayout as! UICollectionViewFlowLayout
        layOut.itemSize = CGSize(width: itemWidth, height: itemWidth)
       // self.downloadItems(url: urlPath)
        
        
        
        
        let parameterss: [String: Any] = [
            "jsonrpc":"2.0",
            "method":"call",
            "params": [
                "kouji_id":33,
                "meisai_no":1,
                
            ]
        ]
        let parameters = ["kouji_id": 42, "meisai_no": 1,] as [String : Any]
        
        
        //create the url with URL
        let url = URL(string: piclistUrl)! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print("joyaa\(error.localizedDescription)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        
        
        Alamofire.request(piclistUrl, method: .post, parameters: parameterss, encoding: JSONEncoding.default)
            .responseString { response in
                print("joysons\(response)")
        }
        
        

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if let HTTPResponse = response as? HTTPURLResponse {
                
               
                let statusCode = HTTPResponse.statusCode
                print("JOY\(statusCode)")
            }
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                
                
                return
            }
//            var dataString = String(data: data, encoding: String.Encoding.utf8)!
//            dataString = dataString.replacingOccurrences(of: "\\'", with: "'")
//
//            let cleanData: NSData = dataString.data(using: String.Encoding.utf8)! as NSData
//            print(cleanData)
            let nsstr = NSString(data: data , encoding: String.Encoding.utf8.rawValue)
            print(nsstr!)
            
            do {
                
                
                
                if let json = try JSONSerialization.jsonObject(with: data , options: []) as? [String: Any] {
//                    for (key,_) in json {
//
//                        //var valuedict = NSArray()
//                        print(json)
//
//                        if key == "details"  {
//                            let valuedict = json[key] as! [String:Any]
//
//                            print(valuedict["pic_list"]!)
//
//                            for (key,_) in valuedict {
//
//                                if key == "pic_list" {
//                                    let realValueDict = valuedict[key] as! NSArray
//                                    print(realValueDict)
//                                    var jsonElement = NSDictionary()
//
//                                    for i in 0 ..< realValueDict.count
//                                    {
//
//                                        jsonElement = realValueDict[i] as! NSDictionary
//                                        print("JOYadrota \(jsonElement.allValues)")
//
//
//
//
//                                        }
//                                        DispatchQueue.main.async {
//
//                                        }
//                                    }
//                                }
//                            }
//
//                        }
                    print("joyson\(json)")
                    
                    }
                    // handle json...
                }
            
            catch let error {
                print(error.localizedDescription)
            }
        
        })
        task.resume()
        
        
    
}
    
    func downloadItems(url:String) {
        
        var url = URLComponents(string: url)!
        url.queryItems = [
            URLQueryItem(name: "flatno", value:"201")
        ]
        
        
        //let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let session = URLSession.shared
        let request = URLRequest(url: url.url!)
        
        let task = session.dataTask(with: request ) { (data, response, error) in
            
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
        self.propertyDetails.removeAll()
        self.flatPhoto.removeAll()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
           
            
            if let pid = jsonElement["pid"] as? String,
                let procat = jsonElement["imgcat"] as? String,
                let flatno = jsonElement["flatno"] as? String,
                let roomname = jsonElement["roomname"] as? String,
                let picture = jsonElement["picture"] as? String,
                let date1 = jsonElement["date"] as? String
            {
                print(procat,flatno,roomname,picture)
                
                if picture != ""
                {
                    let photourl = "\(photourll)"+"\(picture)"
                    print(photourl)
                    
                    if photourl != "" {
                        let ref = photourl
                        let url = URL(string: ref)
                        self.downloadImage(url: url!)
                        
                        
                    }
                    
                    let mydateArray = date1.components(separatedBy: "-")
                    
                    let month = "\(mydateArray[0]) + \(mydateArray[1])"
                    let date = mydateArray[2]
                    print(month,date)
                    if pid != "" {
                        self.pictutrId.append(pid)
                        print(self.pictutrId)
                    }
                    
                    let property = PropertyModel(propertyid: pid, flatRoomimageUrl: photourl, propertyCategory: procat, propertyFlatNo: flatno, flatRoomName: roomname, uiimage: nil, startindMonth: month,startingDate:date)
                    self.propertyDetails.append(property)
                    
                    
                }
                
                
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            
        }
        
        print(self.propertyDetails)
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
                
                let image = FlatRoomPhoto(flatPhoto: img!)
                
                self.flatPhoto.append(image)
                self.collectionView.reloadData()
                
            }
        }
        
    }
    
    
    
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    
    func saveImage(image: UIImage, withName name: String) {
        
        let imageData = NSData(data: UIImagePNGRepresentation(image)!)
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)
        let docs = paths[0] as NSString
        let name = name
        let fullPath = docs.appendingPathComponent(name)
        _ = imageData.write(toFile: fullPath, atomically: true)
    }
    
    func getImage(imageName: String) -> UIImage? {
        
        var savedImage: UIImage?
        
        if let imagePath = getFilePath(fileName: imageName) {
            savedImage = UIImage(contentsOfFile: imagePath)
        }
        else {
            savedImage = nil
        }
        
        return savedImage
        
    }
    
    func getFilePath(fileName: String) -> String? {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        var filePath: String?
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if paths.count > 0 {
            let dirPath = paths[0] as NSString
            filePath = dirPath.appendingPathComponent(fileName)
        }
        else {
            filePath = nil
        }
        
        return filePath
    }
    
    
    
    func buttonClicked(sender:UITapGestureRecognizer) {
        
        
        let tag = sender.view!.tag
        
        self.roomname = self.dictionary[tag]!
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            
            
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            
            self.myImageView = image
            
            DispatchQueue.global(qos: .background).async {
            
                // Go back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.uploadingTest()
                    
                    
                }
            }
            
            self.saveImage(image: image, withName: "drowing1")
            print(self.getImage(imageName: "drowing1")!)
            let asset = FlatRoomPhoto(flatPhoto: self.getImage(imageName:"drowing1")!)
            self.flatPhoto.append(asset)
            self.collectionView.reloadData()
            
            
        }else {
            
            print("cant catch")
        }
    }
    
    
    func downloadItems1() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON1(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON1(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        self.pictutrId.removeAll()
        
        for i in 0 ..< jsonResult.count
        {
            //            [{"pid":"1","procat":"Properties A","flatno":"201","roomname":"Drawing Room","picture":"pic1.jpg"}]
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let pid = jsonElement["pid"] as? String
                
            {
                
                
                
                if pid != "" {
                    self.pictutrId.append(pid)
                    print(self.pictutrId)
                }
                
                
                
            }
            
            
            
            
            
        }
        
        
    }
    
    func uploadingTest() {
        
       // myImageView = UIImage(named:"Drawing")
        //Now use image to create into NSData format
        var imageData = UIImageJPEGRepresentation(myImageView!, 0.25)!
        //Use image's path to create NSData
//        let url:NSURL = NSURL(string : "urlHere")!
//        //Now use image to create into NSData format
//        let imageData:NSData = NSData.init(contentsOfURL: url)!
        imageData.append("Drawing".data(using: String.Encoding.utf8)!)
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)

        
        let upUrlPic = "http://imprest-share.sakura.ne.jp/torepo/script/upload_image.php"
        
        
        
        let parameters = ["kouji_id": 13, "meisai_no": 3 ,"koumoku_id":1, "sekou_status":3,"pic_comment":"写真のコメントです","send_image": strBase64,"team_id":1,"rotation_type":1] as [String : Any]
        
        //create the url with URL
        let url = URL(string: upUrlPic)! //change the url
        
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
            
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                print(statusCode)
            }
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
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
        
    }
    
    
    func UploadRequest()
    {
        
        self.downloadItems1()
        let url = URL(string: "http://tigersoftbd.com/photos.php")
        
        let request = NSMutableURLRequest(url: url!)
        // var request1 = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // let defaults:UserDefaults = UserDefaults.standard
        let intheRoom = self.roomname
        let picName = String((intheRoom?.prefix(4))!)
        
        let realNamePic = "\(String(describing: picName))"+"\(String(describing: self.pictutrId.max()!))"+".png";
        let fname = realNamePic
        
        self.picture = fname
        let mimetype = "image/png"
        
        let parameters = [
            "flatno"    : self.flatno!,
            "roomname" : self.roomname!] as [String:String]?
        let boundary = generateBoundaryString()
        
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (myImageView == nil)
        {
            return
        }
        
        let image_data = UIImageJPEGRepresentation(myImageView, 0.25)
        
        
        if(image_data == nil)
        {
            return
        }
        
        
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
            
        }
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            {
                print(dataString)
            }
            
        })
        
        task.resume()
        
    }
    
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        print(propertyDetails.count)
        return propertyDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        print("hello\(propertyDetails[section].flatRoomName.count)")
        return flatPhoto.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "roomCell", for: indexPath) as! PhotoCell
        
        
        let count = indexPath.row
        
        
        let imag = flatPhoto[indexPath.row].photo
        
        
        cell.photoImageView.image = imag
        
        if flatPhoto.count == count+1 {
            
            cell.cameraBtnImg.image = #imageLiteral(resourceName: "CMB.png")
            cell.cameraBtnImg.tag = indexPath.section
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.buttonClicked))
            
            cell.cameraBtnImg.addGestureRecognizer(tap)
            cell.cameraBtnImg.isUserInteractionEnabled = true
            
            
            
        }
        else {
            cell.cameraBtnImg.image = nil
        }
        
        
        return cell
        
        
    }
    
    func addMyButton() {
        
        
        print("hello")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "roomTitle", for: indexPath) as! SectionHeaderView
            
            headerView.tag  = indexPath.section
            
            headerVieWSectionTag = headerView.tag
            print(headerVieWSectionTag!)
            //let category = roomCategory[indexPath.section]
            let category2 = propertyDetails[indexPath.section]
            
            headerView.sectionTitleLabel.text = category2.flatRoomName
            print(headerView.sectionTitleLabel.text! as Any)
            let headTitle = headerView.sectionTitleLabel.text!
            // let imageName = category.categoryImage
            self.dictionary.updateValue(headTitle, forKey: headerVieWSectionTag!)
            print(self.dictionary)
            
            
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    
    
    
    
    var selectedImage:UIImage!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        let category = roomCategory[indexPath.section]
        
        let tapimage = flatPhoto[indexPath.row]
        
        let image = tapimage.photo
        
        
        self.selectedImage = image
      

        performSegue(withIdentifier: "todetailsVc", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "todetailsVc" {
            
            let detailVc = segue.destination as! DetailViewController
            
            
            detailVc.image = selectedImage
            
        }
    }
    
    func attemptFetch() {
        
        
        
        if runstateSegement.selectedSegmentIndex == 0 {
            
            self.flatPhoto.removeAll()
            self.propertyDetails.removeAll()
            self.downloadItems(url: urlPath)
            
            self.collectionView.reloadData()
            
        } else if runstateSegement.selectedSegmentIndex == 1 {
            self.flatPhoto.removeAll()
            self.propertyDetails.removeAll()
            self.downloadItems(url: oldUrlPath)
            self.collectionView.reloadData()
            
        } else if runstateSegement.selectedSegmentIndex == 2 {
            self.flatPhoto.removeAll()
            self.propertyDetails.removeAll()
            self.downloadItems(url: oldUrlPath)
            self.collectionView.reloadData()
            
        }
        
    }
    
    
    @IBAction func runingStateSegmentAction(_ sender: Any) {
        
        self.attemptFetch()
    }
    
}

