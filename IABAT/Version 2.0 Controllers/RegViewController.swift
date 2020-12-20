//
//  RegViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 8/8/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import EasyAnimation

class RegViewController: UIViewController {

    @IBOutlet weak var loginview: UIView!
    @IBOutlet weak var emailhashed: UITextField!
    @IBOutlet weak var passwordhashed: UITextField!
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet weak var signindesign: UIButton!
    @IBOutlet weak var registerdesign: UIButton!
    
    @IBAction func guest(_ sender: Any) {
        performSegue(withIdentifier: "hi", sender: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailhashed.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailhashed.frame.height))
        emailhashed.leftViewMode = .always
        
        passwordhashed.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailhashed.frame.height))
        passwordhashed.leftViewMode = .always

        
        
        UIButton.animate(withDuration: 2.0, delay: 0.3, animations: {
            
            self.signindesign.layer.cornerRadius = 15
            self.signindesign.layer.shadowColor = UIColor.gray.cgColor
            self.signindesign.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.signindesign.layer.shadowRadius = 10.0
            self.signindesign.layer.shadowOpacity = 0.8
            
            
            self.registerdesign.layer.cornerRadius = 15
            self.registerdesign.layer.shadowColor = UIColor.gray.cgColor
            self.registerdesign.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.registerdesign.layer.shadowRadius = 10.0
            self.registerdesign.layer.shadowOpacity = 0.8
            
        })
        
        
        UILabel.animate(withDuration: 2.0, delay: 0.5, animations: {
            //self.titletext.frame.origin = CGPoint(x: 135, y: 65)
            self.titletext.center.x = self.view.center.x
            self.titletext.center.y = self.loginview.layoutMargins.top + 65
        })
        
        
        
        UIView.animate(withDuration: 2.0, delay: 0.2, animations: {
            self.emailhashed.layer.cornerRadius = 15
            self.passwordhashed.layer.cornerRadius = 15
            self.loginview.layer.cornerRadius = 19
            self.loginview.center.x = self.view.center.x
            self.loginview.center.y = self.view.center.y
            self.loginview.layer.shadowColor = UIColor.gray.cgColor
            self.loginview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.loginview.layer.shadowRadius = 10.0
            self.loginview.layer.shadowOpacity = 0.8
        })
    }
    
    @IBAction func signinactions(_ sender: Any) {
        if let email = emailhashed.text, let password = passwordhashed.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                guard let strongSelf = self else { return }
                if let u = user {
                    print(u)
                    strongSelf.performSegue(withIdentifier: "success", sender: self)
                }
                else {
                    print("No u")
                }
            }
        }
    }
    
    @IBAction func registeractions(_ sender: Any) {
        if let email = emailhashed.text, let password = passwordhashed.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let u = authResult {
                    print(u)
                    self.performSegue(withIdentifier: "success", sender: self)
                } else {
                    self.performSegue(withIdentifier: "badserror", sender: self)
                }
            }
        }
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
