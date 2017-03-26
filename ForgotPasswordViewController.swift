//
//  ForgotPasswordViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    let networkingService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        networkingService.resetPassword(email: emailTextField.text!)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
