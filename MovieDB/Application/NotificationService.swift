//
//  NotificationService.swift
//  MovieDB
//
//  Created by Tim Studt on 27/03/2019.
//  Copyright © 2019 Tim Studt. All rights reserved.
//

import UIKit
import UserNotifications

final class NotificationService {

    private(set) var permissions: UNAuthorizationOptions
    private let center: UNUserNotificationCenter
    private let application: UIApplication

    init(
        permissions: UNAuthorizationOptions = [.sound, .alert, .badge],
        center: UNUserNotificationCenter = .current(),
        application: UIApplication = .shared
    ) {
        self.permissions = permissions
        self.center = center
        self.application = application
    }

    func requestPermission(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: permissions) { [weak self] granted, _ in
            DispatchQueue.main.async {
                if granted {
                    self?.application.registerForRemoteNotifications()
                } else {
                    // Handle error or not granted scenario
                }
                completion(granted)
            }
        }
    }
}

extension NotificationService {
    func sendTestNotifications() {
        //swiftlint:disable identifier_name
        for i in 1...6 {
            let notificationContent = makeNotification(index: i)

            // Deliver the notification in five seconds.
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            // Schedule the notification.
            let request = UNNotificationRequest(identifier: "\(i)FiveSecond", content: notificationContent, trigger: trigger)
            center.add(request) { (error: Error?) in
                if let theError = error {
                    print(theError)
                }
            }
        }
    }

    func makeNotification(index: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Hello!"
        notificationContent.body = "Do not forget the pizza!"
        notificationContent.sound = UNNotificationSound.default

        if index % 2 == 0 {
            notificationContent.threadIdentifier = "Thread1"
            notificationContent.summaryArgument = "Alert1"
        } else {
            notificationContent.threadIdentifier = "Thread2"
            notificationContent.summaryArgument = "Alert2"
        }
        return notificationContent
    }
}
