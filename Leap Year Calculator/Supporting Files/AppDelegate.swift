//
//  AppDelegate.swift
//  Leap Year Calculator
//
//  Created by Kadir Emre on 9.03.2021.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        do {
            let _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        return true
    }
}

