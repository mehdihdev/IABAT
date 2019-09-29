//
//  PrayersViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/9/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import Adhan
import CoreLocation

class PrayersViewController: UIViewController {

    
    //<== MARK: IBOutlets
    @IBOutlet weak var sunriseview: UIView!
    @IBOutlet weak var fajrview: UIView!
    @IBOutlet weak var zuhrview: UIView!
    @IBOutlet weak var asrview: UIView!
    @IBOutlet weak var magrhibview: UIView!
    @IBOutlet weak var ishaview: UIView!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var fajr: UILabel!
    @IBOutlet weak var zuhr: UILabel!
    @IBOutlet weak var asr: UILabel!
    @IBOutlet weak var magrhib: UILabel!
    @IBOutlet weak var isha: UILabel!
    
    var locManager = CLLocationManager()
    
    
    //<== MARK: ovveride func ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        sunriseview.layer.cornerRadius = 15.0
        sunriseview.layer.shadowColor = UIColor.gray.cgColor
        sunriseview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        sunriseview.layer.shadowRadius = 10.0
        sunriseview.layer.shadowOpacity = 0.7
        
        
        fajrview.layer.cornerRadius = 15.0
        fajrview.layer.shadowColor = UIColor.gray.cgColor
        fajrview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        fajrview.layer.shadowRadius = 10.0
        fajrview.layer.shadowOpacity = 0.7
        
        
        
        zuhrview.layer.cornerRadius = 15.0
        zuhrview.layer.shadowColor = UIColor.gray.cgColor
        zuhrview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        zuhrview.layer.shadowRadius = 10.0
        zuhrview.layer.shadowOpacity = 0.7
        
        
        
        asrview.layer.cornerRadius = 15.0
        asrview.layer.shadowColor = UIColor.gray.cgColor
        asrview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        asrview.layer.shadowRadius = 10.0
        asrview.layer.shadowOpacity = 0.7
        
        
        
        magrhibview.layer.cornerRadius = 15.0
        magrhibview.layer.shadowColor = UIColor.gray.cgColor
        magrhibview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        magrhibview.layer.shadowRadius = 10.0
        magrhibview.layer.shadowOpacity = 0.7
        
        
        ishaview.layer.cornerRadius = 15.0
        ishaview.layer.shadowColor = UIColor.gray.cgColor
        ishaview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        ishaview.layer.shadowRadius = 10.0
        ishaview.layer.shadowOpacity = 0.7
        
        
        fetchPrayers()
        
    }
    
    func fetchPrayers() {
        self.locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            currentLocation = locManager.location
            let lat = currentLocation.coordinate.latitude
            let long = currentLocation.coordinate.longitude
            let prayercoordinates = Coordinates(latitude: lat, longitude: long)
            let cal = Calendar(identifier: Calendar.Identifier.gregorian)
            let prayerdate = cal.dateComponents([.year, .month, .day], from: Date())
            var params = CalculationMethod.tehran.params
            params.madhab = .shafi
            if let prayers = PrayerTimes(coordinates: prayercoordinates, date: prayerdate, calculationParameters: params) {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                formatter.timeZone = TimeZone(identifier: "America/New_York")!
                sunrise.text = "Sunrise: \(formatter.string(from: prayers.sunrise))"
                fajr.text = "Fajr: \(formatter.string(from: prayers.fajr))"
                zuhr.text = "Zuhr: \(formatter.string(from: prayers.dhuhr))"
                asr.text = "Asr: \(formatter.string(from: prayers.asr))"
                magrhib.text = "Maghrib: \(formatter.string(from: prayers.maghrib))"
                isha.text = "Isha: \(formatter.string(from: prayers.isha))"
            }
        }
    }
}
