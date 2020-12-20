//
//  EventsDataTableViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/14/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit

//<== MARK: Event Struct as Codable Struct

var selectedEvent :  EventsModel?


class EventsDataTableViewController: UITableViewController, HomeModelProtocol {
    
    

    @IBAction func donecon(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    let searchController = UISearchController(searchResultsController: nil)
    var feedItems: NSArray = NSArray()
    var selectedLocation : EventsModel = EventsModel()
    
    //<== MARK: IBOutlets

    @IBOutlet weak var eventnavigation: UINavigationItem!
    
    @IBAction func gobacktoh(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var listTableView: UITableView!
    
    
    //<== MARK: viewDidLoad() Function
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        //fetchJSON()
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
    }
    
    
    //<== MARK: ovveride func tableView() numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    //<== MARK: ovveride func tableView() cellForRowAt indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        //let cellIdentifier: String = "BasicCell"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        // Get the location to be shown
        let item: EventsModel = feedItems[indexPath.row] as! EventsModel
        // Get references to labels of cell
        myCell.textLabel!.text = item.name
        myCell.detailTextLabel?.text = item.location 
        
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
        selectedEvent = feedItems[indexPath.row] as! EventsModel
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "eventsdetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! DetailViewController
        detailVC.selectedEvent = selectedEvent
    }
    
}
