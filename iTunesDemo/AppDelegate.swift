//
//  AppDelegate.swift
//  iTunesDemo
//
//  Created by Henry.Shih on 2018/11/27.
//  Copyright © 2018 n1. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var service: Service!
    var realm: Realm!

    static func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.service = KKDemoService()
        
        self.realm = try! Realm()
        
        let _ = self.service.APIService.getToken().subscribe({ [weak self] (event) in
            let categoryViewController = CategoryViewController(service: self!.service)
            let playlistViewController = PlaylistViewController(service: self!.service, nibName: "PlaylistViewController")
            playlistViewController.tabBarItem.title = "PlayList"
            categoryViewController.tabBarItem.title = "Category"
            let tabbarController = UITabBarController()
            tabbarController.view.backgroundColor = .white
            tabbarController.viewControllers = [categoryViewController, playlistViewController]
            self?.window?.rootViewController = UINavigationController(rootViewController: tabbarController)
            self?.window?.makeKeyAndVisible()
        })

   
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

