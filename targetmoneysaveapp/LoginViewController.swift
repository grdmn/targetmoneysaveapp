//
//  LoginViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    
    
    var authListener: FIRAuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authListener = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let _ = user {
                self.gotoHome()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FIRAuth.auth()?.removeStateDidChangeListener(authListener!)
    }
    
    func dismissKeyboard() {
        //view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        
        if (emailTextField.text!.characters.count<6) {
            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
            return
        }
        else{
            emailTextField.backgroundColor = UIColor.white
        }
        
        if (passwordTextField.text!.characters.count<6) {
            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
            return
        }
        else{
            passwordTextField.backgroundColor = UIColor.white
        }
        
        let email = emailTextField.text
        let password = passwordTextField.text
        FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (firebaseUser, firebaseError) in
            if let error = firebaseError{
                
                Const().showAlert(title: "Error", message: error.localizedDescription, viewController: self)
                return
            }else{
                
                self.dismiss(animated: true, completion: nil)
            
            }
            
        })
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoHome() {
        let HomeNav = self.storyboard?.instantiateViewController(withIdentifier: "HomeUITabBarController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = HomeNav
    }

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
