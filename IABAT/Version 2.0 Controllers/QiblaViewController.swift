//
//  QiblaViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 9/30/19.
//  Copyright © 2019 IABAT. All rights reserved.
//
 
import UIKit
import CoreLocation
import AVFoundation

class QiblaViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var btnOn: UIButton!
    @IBOutlet var btnOff: UIButton!
    
    var soundon : AVAudioPlayer = AVAudioPlayer()
    var soundoff : AVAudioPlayer = AVAudioPlayer()
    var alarm : AVAudioPlayer = AVAudioPlayer()
    
    @IBAction func soundOn(_ sender: UIButton) {
        soundon.play()
        if btnOff.isHidden == true {
            btnOff.isHidden = false
            btnOn.isHidden = true
        }
    }
    
    @IBAction func soundOff(_ sender: UIButton) {
        soundoff.play()
        if btnOn.isHidden == true {
            btnOn.isHidden = false
            btnOff.isHidden = true
            alarm.stop()
        }
    }
    
    @IBOutlet var Compass: UIImageView!
    @IBOutlet var Needle: UIImageView!

    
    var numberoflaunches : Int! = 0
    
    let latOfKabah = 21.4228394
    let lngOfKabah = 39.8250211
    
    var location: CLLocation?
    let locationManager = CLLocationManager()
    var bearingOfKabah = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initManager()
        btnOff.isHidden = true
    
        do {
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "soundOn", ofType: "mp3")!)
            print(alertSound)
            try soundon = AVAudioPlayer(contentsOf: alertSound)
        }
        catch {
            print("Error Found!")
        }
        
        do {
            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "soundOff", ofType: "mp3")!)
            print(alertSound)
            try soundoff = AVAudioPlayer(contentsOf: alertSound)
        }
        catch {
            print("Error Found!")
        }
        
        do {
            let alarmSound = URL(fileURLWithPath: Bundle.main.path(forResource: "alarm", ofType: "mp3")!)
            print(alarmSound)
            try alarm = AVAudioPlayer(contentsOf: alarmSound)
        }
        catch {
            print("Error Found!")
        }
    }
    
    func initManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        let north = -1 * heading.magneticHeading * Double.pi/180
        let directionOfKabah = bearingOfKabah * Double.pi/180 + north
        
        Compass.transform = CGAffineTransform(rotationAngle: CGFloat(north))
        Needle.transform = CGAffineTransform(rotationAngle: CGFloat(directionOfKabah))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        location = newLocation
        bearingOfKabah = getBearingBetweenTwoPoints1(location!, latitudeOfKabah: self.latOfKabah, longitudeOfKabah: self.lngOfKabah) //calculating the bearing of KABAH
    }
    
    func degreesToRadians(_ degrees: Double) -> Double { return degrees * Double.pi / 180.0 }
    func radiansToDegrees(_ radians: Double) -> Double { return radians * 180.0 / Double.pi }
    
    func getBearingBetweenTwoPoints1(_ point1 : CLLocation, latitudeOfKabah : Double, longitudeOfKabah :Double) -> Double {
        let lat1 = degreesToRadians(point1.coordinate.latitude)
        let lon1 = degreesToRadians(point1.coordinate.longitude)
        let lat2 = degreesToRadians(latitudeOfKabah)
        let lon2 = degreesToRadians(longitudeOfKabah)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        var radiansBearing = atan2(y, x);
        if(radiansBearing < 0.0){
            radiansBearing += 2 * Double.pi
        }
        
        let radians:Float = atan2f(Float(Needle.transform.b), Float(Needle.transform.a))
        let degrees:Float = radians * Float(180 / Double.pi)
        
        if degrees <= 2 && degrees >= -2 && degrees != 0 {
            if btnOn.isHidden == false{
                alarm.play()
            }
            else{
                alarm.stop()
            }
        }

        return radiansToDegrees(radiansBearing)
    }
    
    func LoadNumberOfLaunches() {
        let defaults = UserDefaults.standard
        numberoflaunches = defaults.integer(forKey: "Launches")
    }
    
    func SaveNumberOfLaunches() {
        numberoflaunches = numberoflaunches + 1
        let defaults = UserDefaults.standard
        defaults.set(numberoflaunches, forKey: "Launches")
    }
    
}
