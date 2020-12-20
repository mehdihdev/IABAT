//
//  EventsTableViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/8/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {


    //<== MARK: IBOutlets
    @IBOutlet weak var tableviewcell: UITableViewCell!
    
    //<== MARK: viewDidLoad() Function
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON()
    }


    //<== MARK: Event Struct as Codable Struct

    var events = [Event]()
    
    struct Event: Codable {
        let id, name, location, date: String
        let islamic, time, imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, location, date
            case islamic = "Islamic"
            case time, imageURL
    }
}
    

    //<== MARK: func fetchJSON()
    //this function fetches the JSON from this address "http://iabat.org/data.php" and puts it in
    //the [Events] array, which is later displayed in a UITableView
    func fetchJSON() {
        //making the URL "http://iabat.org/data.php" and making it usable
        
        let urlString = "http://iabat.org/data.php"
        guard let url = URL(string: urlString) else { return }
        
        //Starting the URLSession on main async
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Faild to fetch data from URL: ", err)
                    return
}
                guard let data = data else { return }
                do {
                    //decoding JSON Data
                    let decoder = JSONDecoder()
                    self.events = try decoder.decode([Event].self, from: data)
                    self.tableView.reloadData()
                    
                } catch let jsonErr {
                    print("Failed to decode JSON Data: ", jsonErr)
            }
        }
    //starting JSON Data Task
    }.resume()
}

    
    //<== MARK: ovveride func tableView() numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    //<== MARK: ovveride func tableView() cellForRowAt indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(identifier: "America/New_York")!
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        let event = events[indexPath.row]
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.location + " " + event.date
        return cell
    }
}
