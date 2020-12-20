//
//  HomeModel.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/18/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    let urlPath = "https://iabat.org/data.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let events = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let event = EventsModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let id = jsonElement["id"] as? String,
                let name = jsonElement["name"] as? String,
                let location = jsonElement["location"] as? String,
                let date = jsonElement["date"] as? String,
                let descript = jsonElement["descript"] as? String,
                let Islamic = jsonElement["Islamic"] as? String,
                let time = jsonElement["time"] as? String,
                let imageURL = jsonElement["imageURL"] as? String
            {
                
                event.id = id
                event.name = name
                event.location = location
                event.date = date
                event.descript = descript
                event.Islamic = Islamic
                event.time = time
                event.imageURL = imageURL
                
            }
            
            events.add(event)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: events)
            
        })
    }
}


