//
//  MonthViewController.swift
//  IABAT
//
//  Created by Mehdi Hussain on 4/10/20.
//  Copyright © 2020 IABAT. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController {

    
    @IBOutlet weak var monthtoday: UILabel!
    @IBOutlet weak var importantdates: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFor = DateFormatter()
        let hijriCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        dateFor.locale = Locale.init(identifier: "en") // or "en" as you want to show numbers
        dateFor.calendar = hijriCalendar
        dateFor.dateFormat = "LLLL"
        print(dateFor.string(from: Date()))
        monthtoday.text = "\(dateFor.string(from: Date()))"
        importantdates.text = Ramadan
        
        if "\(dateFor.string(from: Date()))" == "Shaʻban" {
            importantdates.text = Shabaan
        }
        if "\(dateFor.string(from: Date()))" == "Ramadan" {
            importantdates.text = Ramadan
        }
        if "\(dateFor.string(from: Date()))" == "Rajab" {
            importantdates.text = Rajab
        }
        if "\(dateFor.string(from: Date()))" == "Shawwal" {
            importantdates.text = Shawwal
        }
        if "\(dateFor.string(from: Date()))" == "Dhul Qaʻada" {
            importantdates.text = DhulQaada
        }
        /*else {
            importantdates.text = "No Important Dates This Month"
        }*/
        
        
    }
    
    
    
    
    let Shabaan = "1st. Wiladat: BiBi Zainab (S.A.)\n\n2nd. Fasting in Ramzan was made compulsory\n\n3rd. Wiladat: Imam Hussain (AS)\n\n4th. Wiladat: Hazrat Abbas Alamdar (AS)\n\n5th. Wiladat: Imam Zain-ul-Abideen (AS)\n\n7th. Wiladat: Hazrat Qasim Ibne Hasan (AS)\n\n11th. Wiladat: Hazrat Ali Akbar Ibne Hussain (AS)\n\n15th. Wiladat: Imam Mehdi Aakhir-uz-Zaman (AS)"
    let Ramadan = "6th. Torah was revealed.\n10th. Wafat: Hazrat Khadija (SA)\n12th. Bible was revealed.\n15th. Wiladat: Imam Hasan (AS)\n17th. Battle of Badr was fought.\n18th. Zabur was revealed.\n19th. Subhe Zarbat: Imam Ali Ibne Abi Talib (AS)\n21st. Martyrdom: Imam Ali Ibne Abi Talib (AS)\n22nd. Shab-e-Qadr: Quran was revealed"
    let Rajab = "1st. Wiladat (Birth): Imam Muhammad Al Baqir (AS).\n2nd. Wiladat (Birth): Imam Ali Al Hadi (AS).\n10th. Wiladat (Birth): Imam Muhammad Al Jawad (AS).\n13th. Wiladat (Birth): Imam Ali ibn Abi Talib (AS).\n15th. Wafat: Sayyida Zainab bint Ali s.a.\n16th. Wafat: Hazrat Abu Talib\n27th. Yaum-e-Be'sat / Meeraj-un-Nabi (PBUH)"
    let Shawwal = "1st. Eid-Ul-Fitr\n8th. Jannat-ul-Baqee demolished\n10th. Ghaibat Kubra (Imam Aakhir-uz-Zaman AS) began\n17th. Battle of Uhud was fought\n25th.Martyrdom: Imam Jafar-us-Sadiq (AS)"
    let DhulQaada = "11th. Wiladat: Imam Ali Raza (AS)\n25th. Wiladat: Hazrat Ibrahim (AS) and Hazrat Eesaa (AS)\n29th. Martyrdom: Imam Mohammad Taqi (AS)"
    
/*


           //Dhul Hijja
           case "Dhul Hijja":
               switch (dayofDate) {
                   case 1:
                       msg = "Wedding: Imam Ali (AS) and Bibi Fatima Zehra (SA)"
                       break;
                   case 3:
                       msg = "Allah accepted Hazrat Adam's (AS) dua"
                       break;
                   case 5:
                       msg = "Wafat: Hazrat Abu Zur Ghaffari (RA)"
                       break;
                   case 7:
                       msg = "Martyrdom: Imam Mohammad Baqir (AS)"
                       break;
                   case 8:
                       msg = "Imam Hussain (AS) left Makkah towards Karbala"
                       break;
                   case 9:
                       msg = "Martyrdom: Hazrat Muslim Ibne Aqeel (AS) / Yaum-e-Arafat"
                       break;
                   case 10:
                       msg = "Eid-ul-Azha"
                       break;
                   case 15:
                       msg = "Wiladat: Imam Ali-an-Naqi (AS)"
                       break;
                  case 18:
                       msg = "Eid Al-Ghadir"
                       break;
                  case 24:

    }
    
    
    
    */
    
    
    @IBAction func backbutton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    

}
