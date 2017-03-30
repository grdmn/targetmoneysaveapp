//
//  HomeViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var moneyTotalLbl:UILabel!
    @IBOutlet weak var moneyTargetLbl:UILabel!
    @IBOutlet weak var usernameLbl:UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let user = FIRAuth.auth()?.currentUser {
            
            if !user.isEmailVerified {
                AppDelegate.showAlertMsg(withViewController: self, message: "บัญชีของคุณยังไม่ได้รับการยืนยัน โปรดยืนยันบัญชีผู้ใช้")
            }
        } else {
            let alert = UIAlertController(title: "ผิดพลาด!", message: "ไม่มีผู้เข้าสู่ระบบ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction) in
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

        
    }
    

    func gotoHome() {
        let HomeNav = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = HomeNav
    }

    

}
