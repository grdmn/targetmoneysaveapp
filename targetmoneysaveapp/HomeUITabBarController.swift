//
//  HomeUITabBarController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/21/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class HomeUITabBarController: UITabBarController {
    
    var authListener: FIRAuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if FIRAuth.auth()?.currentUser != nil {
            // User is signed in.
            // ...
        } else {
            // No user is signed in.
            // ...
        }
        
    }

}
