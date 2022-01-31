//
//  DetailViewController3.swift
//  IABAT
//
//  Created by Mehdi Hussain on 2/17/21.
//  Copyright © 2021 IABAT. All rights reserved.
//

import UIKit

class DetailViewController3: UIViewController {
    var eventsdetailtitle: String?
    var selectedtimes: String?
    var selectedDescription: String?
    @IBOutlet weak var timetext: UILabel!
    @IBOutlet weak var eventitle: UILabel!
    @IBOutlet weak var joinzoom: UIButton!
    @IBOutlet weak var detaildescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        let newformatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        newformatter.dateFormat = "MM-dd-yyyy hh:mm a"
        let date = formatter.date(from: selectedtimes!)!
        let newdate = newformatter.string(from: date)
        eventitle.text = eventsdetailtitle
        timetext.text = "Time: \(newdate)"
        detaildescription.text = selectedDescription
        joinzoom.layer.cornerRadius = 14
    }
    @IBAction func joinmeetings(_ sender: Any) {
        guard let url = URL(string: "https://meet.iabat.org") else { return }
        UIApplication.shared.open(url)
    }
    

}
