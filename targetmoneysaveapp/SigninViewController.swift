//
//  SigninViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 1/27/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SigninViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // check status firebase
    var authListener: FIRAuthStateDidChangeListenerHandle?
    
    //Action
    
    @IBAction func loginButtonTouch(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
            }
        }

        
    }
    @IBAction func registerButtonTouch(_ sender: Any) {
    
        
    }
    
    @IBAction func resetPasswordButtonTouch(_ sender: Any) {
        
        let resetPasswordAlert = UIAlertController(title: "Reset Password", message: nil, preferredStyle: .alert)
        resetPasswordAlert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter your email"
            textField.clearButtonMode = .whileEditing
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action: UIAlertAction) in
            let textField = resetPasswordAlert.textFields![0]
            
            FIRAuth.auth()?.sendPasswordReset(withEmail: textField.text!) { error in
                if let error = error {
                    AppDelegate.showAlertMsg(withViewController: self, message: error.localizedDescription)
                } else {
                    AppDelegate.showAlertMsg(withViewController: self, message: "Password reset email was sent")
                }
            }
            
        }
        
        resetPasswordAlert.addAction(cancelAction)
        resetPasswordAlert.addAction(confirmAction)
        self.present(resetPasswordAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
//        ref.updateChildValues(["someValue":123123])
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authListener = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
 //               self.gotoProfile()
               self.gotoDashboard()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        FIRAuth.auth()?.removeStateDidChangeListener(authListener!)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method
    
    func gotoDashboard() {
        let dashboardNav = self.storyboard?.instantiateViewController(withIdentifier: "NavDashboardViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = dashboardNav
    }
    
    func gotoProfile() {
        let profileNav = self.storyboard?.instantiateViewController(withIdentifier: "NavProfileViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = profileNav
    }

    


}
