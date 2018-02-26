//
//  LandingPage.swift
//  Firebase2018POC
//
//  Created by Sanad  on 2/26/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import Firebase
class LandingPage: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var displayNameTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       hideKeyboardWhenTappedAround()
        
        
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
        }
        
        
//        let userInfo = Auth.auth().currentUser?.providerData[0]
//        userInfo?.providerID
//        // Provider-specific UID
//        userInfo?.uid
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let vc = Authentication(nibName: "Authentication", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        } catch  {
            print("Invalid Selection.")
        }
    }
    
}
