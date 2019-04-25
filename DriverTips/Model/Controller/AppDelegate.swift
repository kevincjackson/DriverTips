//
//  AppDelegate.swift
//  DriverTips
//
//  Created by Kevin Jackson on 4/13/19.
//  Copyright © 2019 Kevin Jackson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var deliveryStore = DeliveryStore()

    // MARK: - Launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Inject State
        let navVC = window!.rootViewController as! UINavigationController
        let deliveriesVC = navVC.topViewController as! DeliveriesViewController
        deliveriesVC.deliveryStore = deliveryStore

        return true
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        deliveryStore.archive()
    }

}

