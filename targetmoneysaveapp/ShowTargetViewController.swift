//
//  ShowTargetViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/28/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class ShowTargetViewController: UIViewController {

    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var priceTextField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func gotoDashboard() {
        let dashboardNav = self.storyboard?.instantiateViewController(withIdentifier: "NavDashboardViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = dashboardNav
    }
    

    

}
