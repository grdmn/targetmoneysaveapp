//
//  ForgotPiggybankLockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/31/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ForgotPiggybankLockViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let usersReference = ref.child("PasswordlogPiggybank").child((FIRAuth.auth()?.currentUser?.uid)!)
        let value = ["password": self.emailTextField.text, "user": FIRAuth.auth()?.currentUser?.displayName]
        usersReference.updateChildValues(value, withCompletionBlock: {(error,ref) in
            if error != nil{
                print(error!)
                return
            }
            
            print("save password successful into firebase db")
            
            
        })

        
        
        
        }

    
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
}
