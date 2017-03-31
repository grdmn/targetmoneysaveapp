//
//  CannotUnlockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/20/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class CannotUnlockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
    }


    @IBAction func gobacktoHome(_ sender: Any) {
        
        gotoHome()
        
    }
    
    
    func gotoHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let view = storyboard.instantiateViewController(withIdentifier: "HomeUITabBarController") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view
    }
    
    func gotoUnlock() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UnlockPiggybankNav") as UIViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //show window
        appDelegate.window?.rootViewController = view
        
    }

    
    

    

}
