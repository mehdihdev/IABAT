//
//  NewViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 5/2/20.
//  Copyright © 2020 IABAT. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    
     //@IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationController?.navigationBar.isTranslucent = false
        /*tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius=10 //set corner radius here
        tableView.layer.backgroundColor = UIColor.cyan.cgColor*/
    }
    
    

    

}


/*
extension NewViewController: UITableViewDataSource, UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 2
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
      return cell
   }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80
   }
}
*/
