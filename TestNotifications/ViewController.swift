//
//  ViewController.swift
//  TestNotifications
//
//  Created by Shane Whitehead on 4/07/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationsManager.shared.register { (granted, error) in
			print("Granted: \(granted)")
			if let error = error {
				print("\(error)")
			}
		}
	}

	@IBAction func bing(_ sender: AnyObject) {
		NotificationsManager.shared.send()
	}

	@IBAction func bang(_ sender: AnyObject) {
		NotificationsManager.shared.send(now: false)
	}
}

