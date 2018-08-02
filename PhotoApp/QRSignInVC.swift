//
//  QRSignInVC.swift
//  PhotoApp
//
//  Created by RIO on 6/25/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit
import AVFoundation

protocol BarcodeDelegate {
    func barcodeReaded(barcode: String)
}

class QRSignInVC:UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var viewPreview: UIView!
    @IBOutlet weak var lblString: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!
    
    //var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var isReading: Bool = false
    
    var delegate: BarcodeDelegate?
    let signInUrl:String = "http://imprest-share.sakura.ne.jp/torepo/script/login.php"
    
    var videoCaptureDevice: AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    var device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    var output = AVCaptureMetadataOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var captureSession = AVCaptureSession()
    var code: String?
    
    var team_Id = String()
    var user_name = String()
    var result = String()
    var statust = Int()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewPreview.layer.cornerRadius = 5;
        btnStartStop.layer.cornerRadius = 5;
        //captureSession = nil;
        lblString.text = "Barcode discriptio...";
        self.setupCamera()
    }
    

    
   
    
    @IBAction func startStopClick(_ sender: UIButton) {
        if !isReading {
            self.setupCamera()
                btnStartStop.setTitle("Stop", for: .normal)
            
            
        }
        
        isReading = !isReading
    }
    
    private func setupCamera() {
        
        let input = try? AVCaptureDeviceInput(device: videoCaptureDevice)
        
        if self.captureSession.canAddInput(input) {
            self.captureSession.addInput(input)
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        if let videoPreviewLayer = self.previewLayer {
            videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer.frame = self.view.bounds
            view.layer.addSublayer(videoPreviewLayer)
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if self.captureSession.canAddOutput(metadataOutput) {
            self.captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code]
        } else {
            print("Could not add metadata output")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // This is the delegate'smethod that is called when a code is readed
        for metadata in metadataObjects {
            let readableObject = metadata as! AVMetadataMachineReadableCodeObject
            self.code = readableObject.stringValue
            
            
            self.dismiss(animated: true, completion: nil)
            self.delegate?.barcodeReaded(barcode: code!)
            
            
            
        }
        if self.code! != "" {
        
        let parameters = ["qr_data": self.code!,"login_type":2] as [String : Any]
        
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
                        
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "PropertiesDetailsVC") as! PropertiesDetailsVC
                        
                        myVC.user_namee = self.user_name
                        myVC.team_id = self.team_Id
                        self.navigationController?.pushViewController(myVC, animated: true)
                    }else {
                        AlertController.showAlert(self, title: "QR Code Error", message: "Your Scanned are Wrong")
                        
                    }
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
            
            
        })
        task.resume()
        }
    }
}
    

