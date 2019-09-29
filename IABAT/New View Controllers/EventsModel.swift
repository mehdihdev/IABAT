//
//  EventsModel.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/18/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import Foundation

class EventsModel: NSObject {
    
    //properties
    
    var id: String?
    var name: String?
    var location: String?
    var date: String?
    var Islamic: String?
    var time: String?
    var imageURL: String?
    
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    
    init(id: String, name: String, location: String, date: String, Islamic: String, time: String, imageURL: String) {
        self.id = id
        self.name = name
        self.location = location
        self.date = date
        self.Islamic = Islamic
        self.time = time
        self.imageURL = imageURL
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "id: \(id),name: \(name),location: \(location),date: \(date),Islamic: \(Islamic),time: \(time),imageURL: \(imageURL)"
        
    }
    
    
}
