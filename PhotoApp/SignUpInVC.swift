//
//  SignUpInVC.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit



class SignUpInVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var emailForSingInTF: UITextField!
    
    
    @IBOutlet weak var passwordForSignInTF: UITextField!
    
    @IBOutlet weak var subMitBtn: FancyBtn!
    
    @IBOutlet weak var middleSignInINfoLBL: UILabel!
    
    @IBOutlet weak var footerCopyRightLbl: UILabel!
    
    let defaultValues = UserDefaults.standard
    var signInInfo = [String]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var data = Data()
    
    let urlPath: String = "http://tigersoftbd.com/service.php"
    let signInUrl:String = "http://imprest-share.sakura.ne.jp/torepo/script/login.php"
    var team_Id = String()
    var user_name = String()
    var result = String()
    var statust = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
       // self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.activityIndicator =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.view.addSubview(self.activityIndicator)
        
        self.downloadItems()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.activityIndicator.stopAnimating()
        
        
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
                print(self.signInInfo)
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
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let _ = jsonElement["id"] as? String,
                let _ = jsonElement["name"] as? String,
                let email = jsonElement["email"] as? String,
                let password = jsonElement["password"] as? String
            {
                
                
                self.signInInfo.append(email)
                self.signInInfo.append(password)
                
                
                
            }
            
        }
    }
    
    @IBAction func subMitAction(_ sender: Any) {
        
        
        
        let userName = self.emailForSingInTF.text!
        let password = self.passwordForSignInTF.text!
        if userName != "" && password != "" {
            
            
            
            let parameters = ["user": userName, "password": password ,"login_type":1] as [String : Any]
            
            //create the url with URL
            let url = URL(string: self.signInUrl)! //change the url
            
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
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                
                
                guard error == nil else {
                    return
                }
                
                guard data == data else {
                    return
                }
                
                
                do {
                    self.activityIndicator.startAnimating()
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] {
                        for (key,_) in json {
                            
                            if key == "login_user"  {
                                let valuedict = json[key] as! [String:Any]
                                print(valuedict)
                                
                                for (key,_) in valuedict {
                                    
                                    if key == "team_id" {
                                        
                                        self.team_Id = valuedict[key] as! String
                                        
                                        
                                    }
                                    if  key == "user_name" {
                                        self.user_name = valuedict[key] as! String
                                    }
                                    
                                }
                                
                                
                            }
                            if key == "result" {
                                self.result = json[key] as! String
                            }
                            if key == "status" {
                                
                                self.statust = json[key] as! Int
                            }
                            
                        }
                        
                        if self.result == "success" && self.statust == 0 && self.user_name != "" && self.team_Id != "" {
                            
//                            self.performSegue(withIdentifier: "toFlatVC", sender: nil)
                            
                           
                            DispatchQueue.main.async(execute: {
                                let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PropertiesDetailsVC") as! PropertiesDetailsVC
                                
                                myVC.user_namee = self.user_name
                                myVC.team_id = self.team_Id
                                
                                self.activityIndicator.startAnimating()
                                self.navigationController?.pushViewController(myVC, animated: true)
                            })
                        }else if self.statust == 100 {
                            
                            self.activityIndicator.stopAnimating()
                            DispatchQueue.main.async(execute: {
                                self.activityIndicator.startAnimating()
                                AlertController.showAlert(self, title: "ユーザーID未入力 No user ID entered", message: "Please check your user ID")
                            })
                            
                        }else if self.statust == 200 {
                            DispatchQueue.main.async(execute: {
                                self.activityIndicator.startAnimating()
                                AlertController.showAlert(self, title: "パスワード未入力 No password input", message: "Please check your user Password")
                                self.activityIndicator.stopAnimating()
                            })
                           
                            
                        }else if self.statust == 300 {
                            DispatchQueue.main.async(execute: {
                                self.activityIndicator.startAnimating()
                                AlertController.showAlert(self, title: "パスワード未入力 No password input", message: "Please check your user Password")
                                self.activityIndicator.stopAnimating()
                            })
                            
                        }
                        
                    }
                }
                catch let error {
                    print(error.localizedDescription)
                }
                
                
            })
            task.resume()
            self.activityIndicator.startAnimating()
            
            
        }else {
            AlertController.showAlert(self, title: "パスワード未入力 No password input & ユーザーID未入力 No user ID entered", message: "Please check your Text field")
            self.activityIndicator.stopAnimating()
        }
        
        
    }
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    
}

