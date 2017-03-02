//
//  PasswordtoUnlockViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/2/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase

class PasswordtoUnlockViewController: UIViewController {
    
    @IBOutlet weak var confirmPasswordTextField:UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unlockClicked (_ sender: Any){
        
        
        if (confirmPasswordTextField.text!.characters.count<6) {
            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
            return
        }
        else{
            confirmPasswordTextField.backgroundColor = UIColor.white
        }
        
        
        //let password = passwordTextField.text!
        
        
        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
        let usersReference = ref.child("testUser/passwordlock")
        let values = ["passwordunlock": self.confirmPasswordTextField.text]
        usersReference.updateChildValues(values, withCompletionBlock: {(error,ref) in
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

