//
//  QiblaDirectionViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/17/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import CoreLocation

class QiblaDirectionViewController: UIViewController {
    
    @IBOutlet weak var pointything: UIImageView!
    
    var compassManager  : CompassDirectionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        compassManager =  CompassDirectionManager(dialerImageView: pointything, pointerImageView: pointything)
        compassManager.initManager()
        
        

        
    }
    

    

}
