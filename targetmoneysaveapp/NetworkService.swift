//
//  NetworkService.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 3/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

struct NetworkService {
    
    
    var databaseRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference()
    }
    
    //let databaseRef = FIRDatabase.database().reference()
    //let storageRef = FIRStorage.storage().reference()
    
    private func saveInfo(user: FIRUser!,username: String, password: String) {
        //create our user dictionary info
        let userInfo = ["email": user.email!, "username": username, "uid": user.uid, "photoUrl":String(describing: user.photoURL)]
        //create user reference
        let userRef = databaseRef.child("user").child(user.uid)
        //save the user into database 
        userRef.setValue(userInfo)
        
        signIn(email: user.email!, password: password)
        
    }
    
    func signIn(email:String, password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error==nil {
                if user != nil {
                    print("sign in successful")
                    
                    let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
                    let usersReference = ref.child("MoneyCoin").child((FIRAuth.auth()?.currentUser?.uid)!)
                    
                    let addPriceData = ["Email": FIRAuth.auth()?.currentUser?.email as Any]
                    usersReference.setValue(addPriceData)
                    
                    
                }
            }else {
                print(error!.localizedDescription)
            }
        })
    }
    
    private func setUserInfo(user: FIRUser!, username: String, password: String) {
//        //Creat path for the user image
//        let imagePath = "profileImage\(user.uid)/userPic.jpg"
//        //Creat image Reference
//        let imageRef = storageRef.child(imagePath)
//        //Create Metadata for the image
//        let metaData = FIRStorageMetadata()
//        metaData.contentType = "image/jpeg"
//        
//        //Save the user Image in the Firebase Storage File
//        imageRef.put(data as Data, metadata: metaData) {(metaData, error) in
//            
//            if error == nil {
//                let
//                changeRequest.displayName = username
//                changeRequest.commitChanges(completion: { (error) in
//                    
//                    if error == nil{
//                        self.saveInfo(user: user,username:username, password: password)
//                    }else {
//                        print(error?.localizedDescription as Any)
//                    }
//                    
//                })
//            }else {
//                print(error?.localizedDescription as Any)
//            }
//
//        }
        
        
    }
    
    func signUp(email: String, username: String, password: String){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(user: user, username: username, password: password)
                
                let ref = FIRDatabase.database().reference(fromURL: "https://targetmoneysaveapp.firebaseio.com/")
                let usersReference = ref.child("Target").child((FIRAuth.auth()?.currentUser?.uid)!)
                
                let addPriceData = ["Price": FIRAuth.auth()?.currentUser?.email as Any]
                usersReference.setValue(addPriceData)
                
                self.saveInfo(user: user, username: username, password: password)
                
            }else {
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    func resetPassword(email: String) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                print("ระบบกำลังส่งอีเมล์เพื่อเปลี่ยนรหัสผ่านใหม่ของคุณ")
            }
        })
    }
    

}
    
    
    
