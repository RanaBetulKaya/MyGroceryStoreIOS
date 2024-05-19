//
//  AppDelegate.swift
//  MyGroceryStoreIOS
//
//  Created by Rana Betül Kaya on 31.03.2024.
//

import UIKit
import FirebaseCore
import FirebaseAppCheck
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()
        
        // Bildirim iznini isteme
                UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        print("Bildirim izni alınamadı: \(error.localizedDescription)")
                    } else if granted {
                        print("Bildirim izni verildi.")
                    } else {
                        print("Bildirim izni reddedildi.")
                    }
                }
        
        return true
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound, .badge])
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


}

