//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ben on 11/2/18.
//  Copyright © 2018 Ben Pileggi. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
      
        //Used when initializing new realm
        do {
        _ = try Realm()
        
        } catch {
            print("Error initializing new realm, \(error)")
        }
        
      
        
        return true
    }



 
    
}

