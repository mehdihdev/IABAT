//
//  PrayerTimes3ViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 3/27/21.
//  Copyright © 2021 IABAT. All rights reserved.
//

import UIKit
import Adhan
import CoreLocation

class PrayerTimes3ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var fajrtimes: UILabel!
    @IBOutlet weak var dhuhrtimes: UILabel!
    @IBOutlet weak var asrtimes: UILabel!
    @IBOutlet weak var maghribtimes: UILabel!
    @IBOutlet weak var ishatimes: UILabel!
    @IBOutlet weak var prayerblock: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prayerblock.layer.cornerRadius = 21
        getLocation()
        
    }
    
    func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.requestWhenInUseAuthorization()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                @unknown default:
                break
            }
            } else {
                print("Location services are not enabled")
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestWhenInUseAuthorization()
        }
    locationManager.startUpdatingLocation()
}
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // Do Stuff
                }
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
           print("locations = \(locValue.latitude) \(locValue.longitude)")
           let cal = Calendar(identifier: Calendar.Identifier.gregorian)
           let date = cal.dateComponents([.year, .month, .day], from: Date())
           let coordinates = Coordinates(latitude: locValue.latitude, longitude: locValue.longitude)
           //var params = CalculationMethod.moonsightingCommittee.params
          // params.madhab = .hanafi
        var params = CalculationMethod.tehran.params
        //params.madhab = .hanafi
        params.adjustments.fajr = 10
        params.adjustments.asr = -1
        params.adjustments.maghrib = -3
        params.adjustments.isha = 6
           if let prayers = PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params) {
            let current = prayers.currentPrayer()
            print(current)
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.timeZone = TimeZone(identifier: "America/New_York")!
            formatter.timeStyle = .short
            fajrtimes.text = "Fajr: \(formatter.string(from: prayers.fajr))"
            dhuhrtimes.text = "Dhuhr: \(formatter.string(from: prayers.dhuhr))"
            asrtimes.text = "Asr: \(formatter.string(from: prayers.asr))"
            maghribtimes.text = "Maghrib: \(formatter.string(from: prayers.maghrib))"
            ishatimes.text = "Isha: \(formatter.string(from: prayers.isha))"
            
            
            
            
        }
       }

    
}
