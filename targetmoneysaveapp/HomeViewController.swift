//
//  HomeViewController.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/24/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //logOut()
        
        if(FIRAuth.auth()?.currentUser == nil){
            
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginSID")  as! LoginViewController
        
            self.navigationController?.present(loginVC, animated: true, completion: nil)
            
            
        }
        
    }
    
    func logOut() {
        do{
            try FIRAuth.auth()?.signOut()
        }
        catch let error as NSError{
            print(error.localizedDescription)
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
