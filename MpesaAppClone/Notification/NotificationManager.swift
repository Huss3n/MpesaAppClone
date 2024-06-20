//
//  NotificationManager.swift
//  MpesaAppClone
//
//  Created by Muktar Hussein on 12/06/2024.
//

import Foundation
import UserNotifications

struct NotificationModel: Codable, Identifiable  {
    let id: UUID
    let title: String
    let randomID: String
    let amount: String
    let date: Date
}

class NotificationManager {
    static let shared = NotificationManager()
    
    // request user permision to show notifications
    
    private let notificationsKey = "userMpesTRANSACTION"
    @Published var notifications: [NotificationModel] = []
    
    private init() {
        loadNotifications() // <- load notifications from user defaults
    }
    
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Authorization error: \(error.localizedDescription)")
            } else {
                print("Authorization success")
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String, badge: NSNumber, timeInterval: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
//        content.subtitle = subtitle
        content.body = subtitle
        content.userInfo = ["url": "mysafapp://notification"]
        content.badge = badge
        content.sound = UNNotificationSound.default
        
        
        // trigger the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // create request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        // make the call
        UNUserNotificationCenter.current().add(request) { err in
            if let error = err {
                print("Notification error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled: \(title) \(subtitle)")
//                self.saveNotification(title: title, subtitle: subtitle)
            }
        }
        
    }
    
    private func saveNotification(title: String, randomID: String, amount: String, date: Date) {
        let notification = NotificationModel(id: UUID(), title: title, randomID: randomID, amount: amount, date: Date())
         notifications.append(notification)
         saveNotificationsToUserDefaults()
     }
    
    private func saveNotificationsToUserDefaults() {
         if let encoded = try? JSONEncoder().encode(notifications) {
             UserDefaults.standard.set(encoded, forKey: notificationsKey)
         }
     }
    
    private func loadNotifications() {
        if let data = UserDefaults.standard.data(forKey: notificationsKey),
           let decoded = try? JSONDecoder().decode([NotificationModel].self, from: data) {
            notifications = decoded
        }
    }
}
