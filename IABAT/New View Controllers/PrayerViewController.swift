//
//  PrayerViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/19/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import CoreLocation
import Adhan

class PrayerViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var fajrtime: UILabel!
    @IBOutlet weak var dhuhrtime: UILabel!
    @IBOutlet weak var asrtime: UILabel!
    @IBOutlet weak var maghribtime: UILabel!
    @IBOutlet weak var ishatime: UILabel!
    
    @IBAction func backaction(_ sender: Any) {
        
        self.navigationController!.popViewController(animated: true)
        
    }
    
    
    let locationManager = CLLocationManager()
    
    
    
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        getLocation()
        
        
       /* nextprayerviewdesign.layer.cornerRadius = 15.0
        nextprayerviewdesign.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        nextprayerviewdesign.layer.shadowRadius = 20.0
        nextprayerviewdesign.layer.shadowOpacity = 1.0 */
        
        
        
        
        
    }
    
    func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = cal.dateComponents([.year, .month, .day], from: Date())
        let coordinates = Coordinates(latitude: locValue.latitude, longitude: locValue.longitude)
        var params = CalculationMethod.tehran.params
        if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters:     params) {
                let current = prayers.currentPrayer()
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.timeZone = TimeZone(identifier: "America/New_York")!
                formatter.timeStyle = .short
                    fajrtime.text = "\(formatter.string(from: prayers.fajr))"
                    dhuhrtime.text = "\(formatter.string(from: prayers.dhuhr))"
                    asrtime.text = "\(formatter.string(from: prayers.asr))"
                    maghribtime.text = "\(formatter.string(from: prayers.maghrib))"
                    ishatime.text = "\(formatter.string(from: prayers.isha))" 

        }
        
    } 
    



}
