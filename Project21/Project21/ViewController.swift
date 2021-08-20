//
//  ViewController.swift
//  Project21
//
//  Created by JEONGSEOB HONG on 2021/08/19.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Authorization granted!!!!")
            } else {
                print("Authorization rejected....")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        //        var dateComponents = DateComponents()
        //        dateComponents.hour = 10
        //        dateComponents.minute = 30
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let foreground = UNNotificationAction(identifier: "foreground",
                                              title: "foreground action",
                                              options: .foreground)
        let destructive = UNNotificationAction(identifier: "destructive",
                                               title: "destructive action",
                                               options: .destructive)
        let authenticationRequired = UNNotificationAction(identifier: "authenticationRequired",
                                                          title: "authenticationRequired action",
                                                          options: .authenticationRequired)
        
        //identifier를 UNMutableNotificationContent의 categoryIdentifier와 값을 맞춰줘야 하다.
        let category = UNNotificationCategory(identifier: "alarm",
                                              actions: [foreground, destructive, authenticationRequired],
                                              intentIdentifiers: [],
                                              options: [])
        center.setNotificationCategories([category])
    }
    
    
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
        }
        
        var alertController = UIAlertController()
        
        switch response.actionIdentifier {
        // the user swiped to unlock
        case UNNotificationDefaultActionIdentifier:
            alertController = AlertBuilder.simpleAlert(title: "Default identifier")
        // user tapped foreground button
        case "foreground":
            alertController = AlertBuilder.simpleAlert(title: "foreground")
        // user tapped destructive button
        case "destructive":
            alertController = AlertBuilder.simpleAlert(title: "destructive")
        // user tapped authenticationRequired button
        case "authenticationRequired":
            alertController = AlertBuilder.simpleAlert(title: "authenticationRequired")
        default:
            break
        }
        
        present(alertController, animated: true)
        
        // you must call the completion handler when you're done
        completionHandler()
    }
}
