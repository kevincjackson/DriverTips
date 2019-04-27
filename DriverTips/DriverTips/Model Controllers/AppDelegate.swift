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
    var stateController = StateController(storageController: StorageController())

    // MARK: - Launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Inject State
        let tabVC = window!.rootViewController as! UITabBarController
        let nav0 = tabVC.viewControllers?[0] as! UINavigationController
        let deliveriesVC = nav0.topViewController as! DeliveriesViewController
        deliveriesVC.stateController = stateController

        let nav1 = tabVC.viewControllers?[1] as! UINavigationController
        let historyVC = nav1.topViewController as! HistoryViewController
        historyVC.stateController = stateController

        let nav2 = tabVC.viewControllers?[2] as! UINavigationController
        let addressVC = nav2.topViewController as! AddressViewController
        addressVC.stateController = stateController
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        stateController.save()
    }

}

