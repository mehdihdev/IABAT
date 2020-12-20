//
//  ProfileViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/13/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

//<== MARK: Libraries
import UIKit
import Firebase
import FirebaseAuth

//<== MARK: Class ProfileViewontroller as UIViewController
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileview: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var signout: UIButton!
    @IBAction func deleteaccount(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print("Error : \(error)")
            } else {
                print("Account Terminated")
        }
    }
}
    
    
    //<== MARK: IBAction signoutaction
    //this IBAction is supposed to sign out the user, if it fails
    //then it will return an error.
    @IBAction func signoutaction(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "signout", sender: self)
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
    }
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //<== MARK: Profile View Design as profile
        profileview.layer.cornerRadius = 20.0
        profileview.layer.shadowColor = UIColor.gray.cgColor
        profileview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        profileview.layer.shadowRadius = 10.0
        profileview.layer.shadowOpacity = 0.7
        
        //making variable user
        let user = Auth.auth().currentUser
        
        //<== MARK: User Information
        if let user = user {
            //let name = user.displayName
            //let uid = user.uid
            let uidemail = user.email
            //let photoURL = user.photoURL
            email.text = "Email: \(uidemail!)"
        }
    }
}
