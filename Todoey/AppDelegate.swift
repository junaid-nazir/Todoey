//
//  AppDelegate.swift
//  Todoey
//
//  Created by Junaid on 26/03/19.
//  Copyright © 2019 Junaid. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        do{
            _ = try Realm()
           
            
        
        }catch{
            print("Error intialization using realm \(error)")
        }
        
        return true
    }

  

}

