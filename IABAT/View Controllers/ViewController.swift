//
//  ViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 6/27/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Adhan

class ViewController: UIViewController {
    @IBOutlet weak var registerdesign: UIButton!
    @IBOutlet weak var signindesign: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            
            print("User is Signed In")
            
            OperationQueue.main.addOperation {
                [weak self] in
                self?.performSegue(withIdentifier: "login", sender: self)
            }
            
        } else {

            print("No User is Signed In")
        }

        requestNotificationAuthorization()
        registerdesign.layer.cornerRadius = 15
        registerdesign.layer.shadowColor = UIColor.gray.cgColor
        registerdesign.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        registerdesign.layer.shadowRadius = 10.0
        registerdesign.layer.shadowOpacity = 0.7
        signindesign.layer.cornerRadius = 15
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

