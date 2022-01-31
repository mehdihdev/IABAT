//
//  NewViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 5/2/20.
//  Copyright © 2020 IABAT. All rights reserved.
//
import UIKit
import SDWebImage
import CoreLocation
import Adhan


let reuseIdentifier = "EventsIdentify";
let apiUrl = URL(string: "https://new.iabat.org/wp-json/tribe/events/v1/events")
let dateFormatterGet = DateFormatter()
let dateFormatterPrint = DateFormatter()

class HomeViewController3: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var nextprayertime: UILabel!
    @IBOutlet weak var prayersimage: UIImageView!
    @IBOutlet weak var nextprayername: UILabel!
    var events: Array<Dictionary<String,Any>> = [];
    @IBOutlet weak var EventsCollection: UICollectionView!
    @IBOutlet weak var hijridate: UILabel!
    @IBOutlet weak var joinGoogleMeet: UIButton!
    var selectedEvents: String?
    var selectedEventstime: String?
    var selectedEventsdescription: String!
    var dayComponent    = DateComponents()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinGoogleMeet.layer.cornerRadius = 15
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterPrint.dateFormat = "MMM dd, yyyy, hh:mm a"
        let NewFormat = DateFormatter()
        let newhijri = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        NewFormat.locale = Locale.init(identifier: "en")
        NewFormat.calendar = newhijri
        NewFormat.dateFormat = "LLLL dd, YYYY"
        
        dayComponent.day = -1 // For removing one day (yesterday): -1
        let theCalendar = newhijri
        let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())
        hijridate.text = "\(NewFormat.string(from: nextDate!))"
        loadData()
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
    @IBAction func joinGoogleMeetAction(_ sender: Any) {
        guard let url = URL(string: "https://meet.iabat.org") else { return }
        UIApplication.shared.open(url)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//           print("locations = \(locValue.latitude) \(locValue.longitude)")
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
                nextprayername.text = "\(formatter.string(from: prayers.fajr)) prayers"
                prayersimage.image = #imageLiteral(resourceName: "Day Frame")
                
            } else {
                let countdown = prayers.time(for: next!)
                nextprayertime.text = "\(formatter.string(from: countdown))"
                nextprayername.text = "\(next!) prayers"
                if "\(next!)" == "duhr" {
                    prayersimage.image = #imageLiteral(resourceName: "Day Frame")
                }
                if "\(next!)" == "asr" {
                    prayersimage.image = #imageLiteral(resourceName: "Dusk Frame")
                }
                if "\(next!)" == "maghrib" {
                    prayersimage.image = #imageLiteral(resourceName: "Dusk Frame")
                }
                if "\(next!)" == "isha" {
                    prayersimage.image = #imageLiteral(resourceName: "Night Frame")
                }
        }
        }
       }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func donatelink(_ sender: Any) {
        guard let url = URL(string: "https://iabat.org/index.php?option=com_content&view=article&id=25&Itemid=170") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func quranAction(_ sender: Any) {
        guard let url = URL(string: "http://quran.com") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func prayeraction(_ sender: Any) {
        
    }
    @IBAction func duasaction(_ sender: Any) {
        guard let url = URL(string: "http://duas.org") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func directionsaction(_ sender: Any) {
        let directionsURL = "https://maps.apple.com/?daddr=(35.939480,%20-78.841590)&dirflg=d&saddr=(Current%20Location)"
        print(directionsURL)
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
            UIApplication.shared.openURL(url)
}
}
    
    
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1;
    }


        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = EventsCollection.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! EventsCollectionClass
        let row = events[indexPath.row]
        
        if let title = row["title"] as? String {
            print(title)
            selectedEvents = title
            cell.events.text = title
        }
        
        if let date = row["start_date"] as? String {
            if let dated = dateFormatterGet.date(from: date) {
                selectedEventstime = date
                cell.date.text = dateFormatterPrint.string(from: dated)
            } else {
                cell.date.text = "No Date"
               print("There was an error decoding the string")
            }
            if (dateFormatterGet.date(from: date)?.timeIntervalSinceNow.sign == .minus) {
//                cell.contentView.isHidden = true
//                cell.backgroundColor = self.EventsCollection.backgroundColor
                do {

                DispatchQueue.main.async {
                    self.events.remove(at: indexPath.row)
                    self.EventsCollection.deleteItems(at: [indexPath])
                    self.EventsCollection.reloadItems(at: [indexPath])
                    self.EventsCollection.reloadData()
                }
                    
                } catch {
                print("Cannot get Events")
                }
                //self.events.remove(at: indexPath.row)
                

            }
            
        }
        if let descriptions = row["description"] as? String {
            //print(descriptions)
            selectedEventsdescription = descriptions
            print(selectedEventsdescription)
        }
        
        
        cell.layer.cornerRadius = 15
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.events.count == 0) {
            self.EventsCollection.setEmptyMessage("No Events happening right now.")
        } else {
            self.EventsCollection.restore()
        }
        return self.events.count
    }


    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func loadData() {
        let session = URLSession.shared.dataTask(with: URLRequest(url : apiUrl!)) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("Getting Response")
                if(httpResponse.statusCode != 200) {
                    print("NO 200")
                }
            }
            if let myData = data {
                if let json = try? JSONSerialization.jsonObject(with: myData, options: []) as! Dictionary<String,Any> {
                            if let events = json["events"] as? Array<Dictionary<String,Any>> {
                                self.events = events
                                DispatchQueue.main.async {
                                    self.EventsCollection.reloadData()
                                }
                            } else {
                                //ERROR WITH API REQUEST NOT OK
                                print("API Request Failed")
                            }
                } else {
                    print("Error");
                }
            } else {
                print("Errorrrs")
            }
        }
        session.resume();
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "eventdetailed", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get reference to the destination view controller
        let detailVC  = segue.destination as? DetailViewController3
        print(selectedEventsdescription)
        detailVC?.eventsdetailtitle = selectedEvents
        detailVC?.selectedtimes = selectedEventstime
        detailVC?.selectedDescription = selectedEventsdescription
    }
}


extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .tertiaryLabel
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "DMSans-Medium", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
