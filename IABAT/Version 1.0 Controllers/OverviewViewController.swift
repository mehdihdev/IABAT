//
//  OverviewViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 7/8/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import Adhan
import Firebase
import FirebaseAuth
import CoreLocation
import UserNotifications

class OverviewViewController: UIViewController, CLLocationManagerDelegate {
    
    var locManager = CLLocationManager()
    
    //<== MARK: IBOutlets
    @IBOutlet weak var nextprayerview: UIView!
    @IBOutlet weak var nextprayer: UILabel!
    @IBOutlet weak var eventsminiview: UIView!
    @IBOutlet weak var contactview: UIView!
    @IBOutlet weak var contactbutton: UIButton!
    
    //<== MARK: ovveride viewDidLoad func
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        
        if let user = user {
            //let name = user.displayName
            let uid = user.uid
            //let email = user.email
            //let photoURL = user.photoURL
            print(uid)
        }
        
        //<== MARK: nextprayerview design
        nextprayerview.layer.cornerRadius = 15.0
        nextprayerview.layer.shadowColor = UIColor.gray.cgColor
        nextprayerview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        nextprayerview.layer.shadowRadius = 10.0
        nextprayerview.layer.shadowOpacity = 0.7
        
        //<== MARK: events mini view design
        eventsminiview.layer.cornerRadius = 15.0
        eventsminiview.layer.shadowColor = UIColor.gray.cgColor
        eventsminiview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        eventsminiview.layer.shadowRadius = 10.0
        eventsminiview.layer.shadowOpacity = 0.7
        
        //<== MARK: contactview design
        contactview.layer.cornerRadius = 15.0
        contactview.layer.shadowColor = UIColor.gray.cgColor
        contactview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        contactview.layer.shadowRadius = 10.0
        contactview.layer.shadowOpacity = 0.7
        

        //<== MARK: locmanager Authorization
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        
        var currentLocation: CLLocation!
        
        //<== MARK: CLLocation Authorized Function
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            locManager.startUpdatingLocation()
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
                formatter.dateFormat = "HH:mm"
                formatter.timeStyle = .short
                formatter.timeZone = TimeZone(identifier: "America/New_York")!
                let next = prayers.nextPrayer()
                let countdown = prayers.time(for: next!)
                nextprayer.text =  "Next Prayer at: \(formatter.string(from: countdown))"
                
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: "Time to Pray", arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: "The Time is: \(formatter.string(from: countdown))",
                arguments: nil)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let calendar = Calendar.current
                let comp = calendar.dateComponents([.hour, .minute], from: countdown)
                let hour = comp.hour
                let minute = comp.minute
                var dateInfo = DateComponents()
                dateInfo.hour = hour
                dateInfo.minute = minute
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
                let request = UNNotificationRequest(identifier: "PrayerTime", content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
                
                center.add(request) { (error : Error?) in
                    if let theError = error {
                        print(theError.localizedDescription)
                    }
                }
            }
        }
            
            
            
            //<== MARK: CLLocation Not Authorized or undetermined
            if (CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined) {
                currentLocation = locManager.location
                let lat = 35.928880
                print(lat)
                let long = -78.813670
                print(long)
                let prayercoordinates = Coordinates(latitude: lat, longitude: long)
                
                
                let cal = Calendar(identifier: Calendar.Identifier.gregorian)
                let prayerdate = cal.dateComponents([.year, .month, .day], from: Date())
                var params = CalculationMethod.tehran.params
                params.adjustments.sunrise = 1
                params.adjustments.fajr = 12
                params.adjustments.dhuhr = 1
                params.adjustments.maghrib = -3
                params.adjustments.isha = 7
                params.madhab = .shafi
                
                
                if let prayers = PrayerTimes(coordinates: prayercoordinates, date: prayerdate, calculationParameters: params) {
                    let formatter = DateFormatter()
                    formatter.timeZone = TimeZone(identifier: "America/New_York")!
                    formatter.dateFormat = "HH:mm"
                    formatter.timeStyle = .short
                    let next = prayers.nextPrayer()
                    let countdown = prayers.time(for: next!)
                    nextprayer.text =  "Next Prayer at: \(formatter.string(from: countdown))"
            }
        }
    }
}
    

