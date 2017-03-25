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
            
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
            }catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }

        
    }

}
