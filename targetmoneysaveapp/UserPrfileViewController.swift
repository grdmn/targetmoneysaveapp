//
//  UserPrfileViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 4/3/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UserPrfileViewController: UIViewController {
    
    @IBOutlet weak var Usernamelabel:UILabel!
    @IBOutlet weak var Emaillabel:UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setUserDataToView(withFIRUser user: FIRUser) {
        
        Usernamelabel.text = user.displayName
        Emaillabel.text = user.email
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = FIRAuth.auth()?.currentUser {
            
            setUserDataToView(withFIRUser: user)
            
        } else {
            let alert = UIAlertController(title: "ผิดพลาด!", message: "ไม่มีผู้เข้าสู่ระบบ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ตกลง", style: .default, handler: { (action: UIAlertAction) in
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        

    }
    
    
    
    

    func signout() {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
