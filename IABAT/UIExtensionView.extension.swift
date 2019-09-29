//
//  UIExtensionView.extension.swift
//  IABAT
//
//  Created by Mehdi Hussain on 6/28/19.
//  Copyright © 2019 IABAT. All rights reserved.
//
import UIKit
import UserNotifications

extension UIViewController {
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            //print("User Notification settings: (settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(
            options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                //print("Notification granted: (granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
}
