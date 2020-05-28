//
//  UIViewController+Context.swift
//  MoviesLib
//
//  Created by Ygor Duarte Lemos Pereira on 25/05/20.
//  Copyright © 2020 Ygor Duarte Lemos Pereira. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate        
        return appDelegate.persistentContainer.viewContext
    }
}
