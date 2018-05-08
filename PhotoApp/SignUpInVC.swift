//
//  SignUpInVC.swift
//  PhotoApp
//
//  Created by JOY BISWAS on 5/6/18.
//  Copyright © 2018 MacBook Air. All rights reserved.
//

import UIKit

class SignUpInVC: UIViewController {
    
    
    @IBOutlet weak var emailForSingInTF: UITextField!
    

    @IBOutlet weak var passwordForSignInTF: UITextField!
    
    @IBOutlet weak var subMitBtn: FancyBtn!
    
    @IBOutlet weak var middleSignInINfoLBL: UILabel!
    
    @IBOutlet weak var footerCopyRightLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func subMitAction(_ sender: Any) {
        
        performSegue(withIdentifier: "toAppartMentVC", sender: nil)
    }



}

