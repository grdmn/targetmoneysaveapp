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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        
        if (emailTextField.text!.characters.count<6) {
            Const().showAlert(title: "Error", message: "Email more than 6 character", viewController: self)
            return
        }
        else{
            emailTextField.backgroundColor = UIColor.white
            
            let email = emailTextField.text!
            
            FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (firebaseError) in
                if let error = firebaseError
                {
                    Const().showAlert(title: "Error", message: error.localizedDescription, viewController: self)
                    return
                }else{
                    let alert = UIAlertController(title: "Success", message: "Reset Password", preferredStyle: .alert)
                    let resultAlert = UIAlertAction(title: "OK", style: .default, handler: {
                        (alertAction) in
                        
                        self.navigationController!.popViewController(animated: true)
                    })
                    alert.addAction(resultAlert)
                    self.present(alert, animated: true, completion: nil)
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
