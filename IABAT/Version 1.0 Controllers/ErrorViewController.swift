//
//  ErrorViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/4/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var errortitle: UILabel!
    @IBOutlet weak var errorbody: UILabel!
    @IBOutlet weak var errorview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorview.layer.cornerRadius = 10
        errorview.layer.masksToBounds = true
    }
    
    
    @IBAction func errorokaction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}
