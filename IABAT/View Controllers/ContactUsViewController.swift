//
//  ContactUsViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/17/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import CoreLocation
import SafariServices

class ContactUsViewController: UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var iabatcontactlogo: UIImageView!
    @IBOutlet weak var mehdiphoto: UIImageView!
    @IBOutlet weak var iabatwebsiteview: UIView!
    @IBOutlet weak var mehdiview: UIView!
    
    
   /* @IBAction func iabatwebsitebutton(_ sender: Any) {
        if let url = URL(string: "http://iabat.org") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func mehdiwebsite(_ sender: UIButton) {
        
        if let url = URL(string: "http://mehdi.us") {
            UIApplication.shared.open(url)
        }
    }
 
 */

    
    @IBAction func directionsbutton(_ sender: UIButton) {
            let directionsURL = "https://maps.apple.com/?daddr=(35.928880,%20-78.813672)&dirflg=d&saddr=(Current%20Location)"
            print(directionsURL)
            guard let url = URL(string: directionsURL) else {
                return
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
                UIApplication.shared.openURL(url)
    }
}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iabatcontactlogo.layer.borderWidth = 1
        iabatcontactlogo.layer.masksToBounds = false
        iabatcontactlogo.layer.borderColor = UIColor.black.cgColor
        iabatcontactlogo.layer.cornerRadius = iabatcontactlogo.frame.height/2
        iabatcontactlogo.clipsToBounds = true
        
        mehdiphoto.layer.borderWidth = 1
        mehdiphoto.layer.masksToBounds = false
        mehdiphoto.layer.borderColor = UIColor.black.cgColor
        mehdiphoto.layer.cornerRadius = iabatcontactlogo.frame.height/2
        mehdiphoto.clipsToBounds = true
        
        iabatwebsiteview.layer.cornerRadius = 15.0
        iabatwebsiteview.layer.shadowColor = UIColor.gray.cgColor
        iabatwebsiteview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        iabatwebsiteview.layer.shadowRadius = 10.0
        iabatwebsiteview.layer.shadowOpacity = 0.7
        
        mehdiview.layer.cornerRadius = 15.0
        mehdiview.layer.shadowColor = UIColor.gray.cgColor
        mehdiview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mehdiview.layer.shadowRadius = 10.0
        mehdiview.layer.shadowOpacity = 0.7
}
    

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
