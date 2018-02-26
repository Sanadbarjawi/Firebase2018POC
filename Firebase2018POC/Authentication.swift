//
//  Authentication.swift
//  Firebase2018POC
//
//  Created by Sanad  on 2/26/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import Firebase

class Authentication: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()//To hide keyboard when tapped around (vc extention)
        RegisterButton.layer.borderWidth = 1
        RegisterButton.layer.borderColor = UIColor.white.cgColor
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        dismissKeyboard()
        if userNameTxtField.text != "" || userNameTxtField.text != nil {
            Auth.auth().createUser(withEmail: userNameTxtField.text!, password: passwordTxtField.text!) { (user, error) in
                if error == nil {
                    print("Registeration Successful!")
                }else{
                    let message = error?.localizedDescription
                    let Alert = UIAlertController(title: "Registeration", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        Alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(Alert, animated: true, completion: nil)
                }
                
            }
        }
    
        
    }
}
