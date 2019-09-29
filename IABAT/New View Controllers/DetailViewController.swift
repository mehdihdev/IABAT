//
//  DetailViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/14/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBAction func backtothegoodstuffings(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
        
    }
    @IBOutlet weak var eventtitle: UILabel!
    @IBOutlet weak var eventtime: UILabel!
    
    var selectedEvent : EventsModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let event = selectedEvent?.name
        eventtitle.text = event
        eventtime.text = selectedEvent?.date
    }
    
}
