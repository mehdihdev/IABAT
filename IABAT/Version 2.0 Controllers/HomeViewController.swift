//
//  HomeViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 8/9/19.
//  Copyright © 2019 IABAT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAnalytics
import GoogleMobileAds
import CoreLocation
import Adhan

class HomeViewController: UIViewController, GADBannerViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var bannerView: GADBannerView!

    @IBOutlet weak var nextprayerpreview: UIView!
    @IBOutlet weak var eventspreview: UIView!
    @IBOutlet weak var prayertimespreview: UIView!
    @IBOutlet weak var qiblaview: UIView!
    @IBOutlet weak var donations: UIView!
    @IBOutlet weak var eventsredview: UIView!
    @IBOutlet weak var prayerredview: UIView!
    @IBOutlet weak var qiblaredview: UIView!
    @IBOutlet weak var servicesredview: UIView!
    @IBOutlet weak var prayeractualtime: UILabel!
    @IBOutlet weak var nextprayers: UILabel!
    @IBOutlet weak var hijrimonth: UILabel!
    @IBOutlet weak var islamicdate: UILabel!
    
    
    override func viewDidLoad() {
        
        let dateFor = DateFormatter()
        let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        dateFor.locale = Locale.init(identifier: "en")
        dateFor.calendar = hijriCalendar
        dateFor.dateFormat = "LLLL"
        print(dateFor.string(from: Date()))
        hijrimonth.text = "\(dateFor.string(from: Date()))"
        
        let NewFormat = DateFormatter()
        let newhijri = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        NewFormat.locale = Locale.init(identifier: "en")
        NewFormat.calendar = newhijri
        NewFormat.dateFormat = "LLLL dd, YYYY"
        islamicdate.text = "\(NewFormat.string(from: Date()))"
        
        
        self.navigationController?.navigationBar.barTintColor  = UIColor(hex: "2D3447")
        
        locationManager.requestWhenInUseAuthorization()
        getLocation()
        
        //nextprayerpreview.backgroundColor = UIColor(hex: "2D3447")
        //The Very good Color is hex: 2D3447
        nextprayerpreview.layer.cornerRadius = 15.0
        nextprayerpreview.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        nextprayerpreview.layer.shadowRadius = 20.0
        nextprayerpreview.layer.shadowOpacity = 1.0
        
        eventspreview.layer.cornerRadius = 15.0
        eventspreview.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        eventspreview.layer.shadowRadius = 20.0
        eventspreview.layer.shadowOpacity = 1.0
        
        prayertimespreview.layer.cornerRadius = 15.0
        prayertimespreview.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        prayertimespreview.layer.shadowRadius = 20.0
        prayertimespreview.layer.shadowOpacity = 1.0
        
        qiblaview.layer.cornerRadius = 15.0
        qiblaview.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        qiblaview.layer.shadowRadius = 20.0
        qiblaview.layer.shadowOpacity = 1.0
        
        donations.layer.cornerRadius = 15.0
        donations.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        donations.layer.shadowRadius = 20.0
        donations.layer.shadowOpacity = 1.0

        eventsredview.layer.backgroundColor = UIColor(red: 0.84, green: 0.08, blue: 0.08, alpha: 1).cgColor
        eventsredview.layer.cornerRadius = eventsredview.frame.size.width/2
        eventsredview.clipsToBounds = true
        
        prayerredview.layer.backgroundColor = UIColor(red: 0.84, green: 0.08, blue: 0.08, alpha: 1).cgColor
        prayerredview.layer.cornerRadius = eventsredview.frame.size.width/2
        prayerredview.clipsToBounds = true
        
        qiblaredview.layer.backgroundColor = UIColor(red: 0.84, green: 0.08, blue: 0.08, alpha: 1).cgColor
        qiblaredview.layer.cornerRadius = eventsredview.frame.size.width/2
        qiblaredview.clipsToBounds = true
        
        servicesredview.layer.backgroundColor = UIColor(red: 0.84, green: 0.08, blue: 0.08, alpha: 1).cgColor
        servicesredview.layer.cornerRadius = eventsredview.frame.size.width/2
        servicesredview.clipsToBounds = true
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-8345003556846937/6811492493"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    
    @IBAction func duasactions(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "http://duas.org")!)
        
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
               let next = prayers.nextPrayer()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.timeZone = TimeZone(identifier: "America/New_York")!
            formatter.timeStyle = .short
            
            
            if next == nil {
                
                let next = "Fajr"
                nextprayers.text = "\(formatter.string(from: prayers.fajr))"
                
            } else {
                let countdown = prayers.time(for: next!)
                prayeractualtime.text = "\(formatter.string(from: countdown))"
                nextprayers.text = "\(next!)"
            }
               
               
               
           }
           
       }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bannerView)
            view.addConstraints ([
                    NSLayoutConstraint(item: bannerView,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: bottomLayoutGuide,
                    attribute: .top,
                    multiplier: 1,
                    constant: 0),
                    NSLayoutConstraint(item: bannerView,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: view,
                    attribute: .centerX,
                    multiplier: 1,
                    constant: 0
            )
        ])
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}


