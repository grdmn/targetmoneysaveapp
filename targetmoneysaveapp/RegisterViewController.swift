//
//  RegisterViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    var authListener: FIRAuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
//        if (emailTextField.text!.characters.count<6) {
//            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
//            return
//        }
//        else{
//            emailTextField.backgroundColor = UIColor.white
//        }
//        
//        if (passwordTextField.text!.characters.count<6) {
//            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
//            return
//        }
//        else{
//            passwordTextField.backgroundColor = UIColor.white
//        }
//        
//        let email = emailTextField.text
//        let password = passwordTextField.text
//        FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (firebaseUser, firebaseError) in
//            if let error = firebaseError{
//                
//                Const().showAlert(title: "Error", message: error.localizedDescription, viewController: self)
//                return
//            }else{
//                
//                Const().showAlert(title: "Signin Success", message: "OK", viewController: self)
//                return
//            }
//            
//        })
//
//        if !confirmPasswordTextField.text!.isEqual(passwordTextField.text!) {
//            
//            confirmPasswordTextField.backgroundColor = UIColor.red
//            
//            Const().showAlert(title: "Error", message: "Password no match!", viewController: self)
//            return
//        }else{
//            confirmPasswordTextField.backgroundColor = UIColor.white
//            
//            let email = emailTextField.text!
//            let password = passwordTextField.text!
//            return
//        }
            
            
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            
            let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["email": self.emailTextField.text, "password": self.passwordTextField.text]
            usersReference.updateChildValues(values, withCompletionBlock: {(error,ref) in
                if error != nil{
                    print(error!)
                    return
                }
                
                print("save user successful into firebase db")
                
                
            })
            
            
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authListener = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                //self.gotoDashboard()
                self.gotoHome()
            }
        })
    }

    func gotoHome() {
        let HomeNav = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = HomeNav
    }


}
