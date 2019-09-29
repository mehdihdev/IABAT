//
//  SignInViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 6/29/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

//<== MARK: Libraries
import UIKit
import Firebase
import FirebaseAuth

//<== MARK: Class SignInViewcontroller
class SignInViewController: UIViewController {

    //<== MARK: IBOutlets
    @IBOutlet weak var backdesign: UIButton!
    @IBOutlet weak var signinviewdesign: UIView!
    @IBOutlet weak var signindesign: UIButton!
    @IBOutlet weak var usernamesign: UITextField!
    @IBOutlet weak var passwordsign: UITextField!
    
    //<== MARK: ovveride func viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //<== MARK: Back Button Design as backdesign
        backdesign.layer.cornerRadius = 10
        
        //<== MARK: Sign In View design as signinviewdesign
        signinviewdesign.layer.cornerRadius = 25
        signinviewdesign.layer.shadowColor = UIColor.black.cgColor
        signinviewdesign.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        signinviewdesign.layer.shadowRadius = 12.0
        signinviewdesign.layer.shadowOpacity = 0.7
        
        //<== MARK: Sign In Button Design as signindesign
        signindesign.layer.cornerRadius = 10
}

    //<== MARK: IBAction signinaction
    //This IBAction is supposed to sign in any existing users using the IOS App through Firebase
    //If the Sign in is successful, it sends it to a popup error
    @IBAction func signinaction(_ sender: Any) {
        //<== MARK: if let email,password statement
        if let email = usernamesign.text, let password = passwordsign.text {
        //<== MARK: Auth.auth.signIn statement
        //This statement is supposed to sign in any existing users using the IOS App through Firebase
        //If the Sign in is successful, it sends it to a popup error
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            //setting strongSelf as a Self with a return value
            guard let strongSelf = self else { return }
            //<== MARK: if let u = user statement
            if let u = user {
            print(u) //This is here just to silence a warning, not critical at all
            strongSelf.performSegue(withIdentifier: "loginsuccess", sender: self)
            //<== MARK: end of if u = user statement
            }
            //<== MARK: else statment for Auth.auth.signIn statment
            //This Statement only triggers if the sign in fails
            else {
                strongSelf.performSegue(withIdentifier: "error", sender: self)
                //<== MARK: end of else for Auth.auth().signIn
                }
            //<== MARK: end of Auth.auth.signIn
            }
        //<== MARK: end of if let email,password statment
        }
    //<== MARK: end of IBAction signinaction
    }
    
    
    //<== MARK: ovveride func touchesBegan()
    //This ovveride function is supposed to trigger when the user presses anywhere on the screen
    //other than the keyboard, if this happens, this function removes the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
