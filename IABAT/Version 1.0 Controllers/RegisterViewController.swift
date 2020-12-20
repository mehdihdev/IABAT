//
//  RegisterViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 12/24/18.
//  Copyright © 2019 IABAT. All rights reserved.
//

//<== MARK: Libraries
import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    //<== MARK: IBOutlets
    @IBOutlet weak var registerview: UIView!
    @IBOutlet weak var emailregistertext: UITextField!
    @IBOutlet weak var passwordregistertext: UITextField!
    @IBOutlet weak var registerbuttondesign: UIButton!
    @IBOutlet weak var backbuttondesign: UIButton!
    
    
    //<== MARK: ovveride func ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register View design as 'registerview'
        registerview.layer.cornerRadius = 20.0
        registerview.layer.shadowColor = UIColor.gray.cgColor
        registerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        registerview.layer.shadowRadius = 12.0
        registerview.layer.shadowOpacity = 0.7
        
        //Register Button Design as 'registerbuttondesign'
        registerbuttondesign.layer.cornerRadius = 15.0
        registerbuttondesign.layer.shadowColor = UIColor.gray.cgColor
        registerbuttondesign.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        registerbuttondesign.layer.shadowRadius = 12.0
        registerbuttondesign.layer.shadowOpacity = 0.7
        
        //Back Button Design as 'backbuttondesign'
        backbuttondesign.layer.cornerRadius = 15.0
        backbuttondesign.layer.shadowColor = UIColor.gray.cgColor
        backbuttondesign.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        backbuttondesign.layer.shadowRadius = 12.0
        backbuttondesign.layer.shadowOpacity = 0.7
}
    
    
    //<== MARK: IBAction registerbuttonaction
    //this IBAction is for registering the user via firebase, if succesful, sends the user to the home screen.
    //if not, gives the user a popup to try again.
    @IBAction func registerbuttonaction(_ sender: UIButton) {
        if let email = emailregistertext.text, let password = passwordregistertext.text {
             Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let u = authResult {
                    print(u)
                    self.performSegue(withIdentifier: "registersuccess", sender: self)
                } else {
                    self.performSegue(withIdentifier: "badserror", sender: self)
            }
        }
    }
}
    

    //<== MARK: ovveride func touchesBegan() as UITouch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        self.view.endEditing(true)
    }


}

