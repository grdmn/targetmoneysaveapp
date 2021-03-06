
//  AppDelegate.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/10/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        notificationCenter.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            
        }
        
        application.registerForRemoteNotifications()
        
        FIRApp.configure()
        
        //FIRDatabase.database().persistenceEnabled = true

        NotificationCenter.default.addObserver(self, selector: #selector(self.getFIRToken(notification:)), name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        FIRMessaging.messaging().disconnect()
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        connectFIRMessaging()
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //for Alert
    static func showAlertMsg(withViewController vc: UIViewController, message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    func getFIRToken(notification: NSNotification) {
        let firToken = FIRInstanceID.instanceID().token()
        print("InstanceID token:\(String(describing: firToken))")
        
        connectFIRMessaging()
    }
    
    func connectFIRMessaging(){
        FIRMessaging.messaging().connect { (firebaseError) in
            if (firebaseError != nil) {
                print("\(String(describing: firebaseError?.localizedDescription))")
            }
            else {
                print("successful connect to FIRMessaging")
            }
        }
    }



}

