//
//  NotificationsManager.swift
//  TestNotifications
//
//  Created by Shane Whitehead on 4/07/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

import UserNotifications

class NotificationsManager: NSObject {
	static let shared: NotificationsManager = NotificationsManager()
	
	func register(completionHandler: (Bool, NSError?) -> Void) {
		UNUserNotificationCenter.current().requestAuthorization([.alert, .sound, .badge]) { (granted, error) in
			if granted {
				UNUserNotificationCenter.current().delegate = self
				let accept = UNNotificationAction(identifier: "accept", title: "Accept", options: [.authenticationRequired, .foreground])
				let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: [.destructive])
				let category = UNNotificationCategory(identifier: "message",
				                                      actions: [accept, cancel],
				                                      minimalActions: [accept, cancel],
				                                      intentIdentifiers: [],
				                                      options: [])
				UNUserNotificationCenter.current().setNotificationCategories([category])
			}
			completionHandler(granted, error)
		}
	}
	
	func send(now: Bool = true) {
		let content = UNMutableNotificationContent()
		content.title = "This is a test"
		content.subtitle = "In Space"
		content.body = "Army boots"
		content.categoryIdentifier = "message"
		
		var timeInterval = 1.0
		if !now {
			timeInterval = 10.0
		}
		
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval,
		                                                repeats: false)
		
		let identifier = "test"
		let request = UNNotificationRequest(identifier: identifier,
		                                    content: content,
		                                    trigger: trigger)
		
		UNUserNotificationCenter.current().add(request) { (error) in
			print("Added with error \(error)")
		}
	}
}

extension NotificationsManager: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter,
	                            didReceive response: UNNotificationResponse,
	                            withCompletionHandler completionHandler: () -> Void) {
		print("didReceive response \(response.actionIdentifier)")		
		completionHandler()
		
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter,
	                            willPresent notification: UNNotification,
	                            withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
		print("willPresent notification")
		completionHandler([.alert, .badge, .sound])
	}
}
