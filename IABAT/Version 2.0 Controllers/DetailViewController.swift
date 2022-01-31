//
//  DetailViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/14/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

     var selectedEvent : EventsModel?
    @IBAction func backtothegoodstuffings(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var eventtitle: UILabel!
    @IBOutlet weak var eventtime: UILabel!
    @IBOutlet weak var eventdescript: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let event = selectedEvent?.name
        eventtitle.text = selectedEvent?.name
        eventtime.text = selectedEvent?.date
        eventdescript.text = selectedEvent?.descript
    }
    
    
      @IBAction func joinzooms(_ sender: Any) {
        let url = "\((selectedEvent?.imageURL)!)"
        UIApplication.shared.openURL(URL(string: url)!)
        print(url)
    }
    
    
}
