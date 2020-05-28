//
//  AppDelegate.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 20/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    // MARK: CoreData Stack
    //Manage Object Model: Describe data schema
    //Persistent Store Coordinator: Manages Persistent Store, give access to the data base (SQLite by default)
    //Manage Object Context: It is an area to work with the data that will be persisted in Persistent Store
    //Persistent Container: Object that manages everything from CoreData Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesLib")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Erro ao carregar a Strore: \(error.localizedDescription)")
            }
        }
              
        return container
    }()
    
}
