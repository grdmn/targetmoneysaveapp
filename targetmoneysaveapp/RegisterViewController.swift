//
//  RegisterViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
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
                
                Const().showAlert(title: "Signin Success", message: "OK", viewController: self)
                return
            }
            
        })

        if !confirmPasswordTextField.text!.isEqual(passwordTextField.text!) {
            
            confirmPasswordTextField.backgroundColor = UIColor.red
            
            Const().showAlert(title: "Error", message: "Password no match!", viewController: self)
            return
        }else{
            confirmPasswordTextField.backgroundColor = UIColor.white
            
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (firebasUser, firebaseError) in
                
                if let error = firebaseError{
                    
                    Const().showAlert(title: "Error", message: error.localizedDescription, viewController: self)
                    return
                }else{
                    
                    let alert = UIAlertController(title: "Success", message: "Login successed", preferredStyle: .alert)
                    let resultAlert = UIAlertAction(title: "OK", style: .default, handler: {
                        (alertAction) in
                        
                        self.navigationController!.popViewController(animated: true)
                        
                    })
                    
                    alert.addAction(resultAlert)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }

                
            })
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
