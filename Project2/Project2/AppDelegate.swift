//
//  AppDelegate.swift
//  Project2
//
//  Created by JEONGSEOB HONG on 2021/06/27.
//

import UserNotifications
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        scheduleUserNotification()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func scheduleUserNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            granted ? print("granted") : print("they don't want push")
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Let's time to play Game!"
        content.body = "The time which you play last before"
        content.sound = .default
        
        let date = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: date)
        let currentMinutes = calendar.component(.minute, from: date)
        var dateComponents = DateComponents()
        dateComponents.hour = currentHour
        dateComponents.minute = currentMinutes
        print("currentHour:", currentHour)
        print("currentMinutes:", currentMinutes)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)  // for test
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        center.add(request)
        print("added")
    }
    
    
    
}

