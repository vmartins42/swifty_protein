//
//  ViewController.swift
//  Swifty_protein
//
//  Created by Victor MARTINS on 4/23/19.
//  Copyright © 2019 Victor MARTINS. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var authBtn: UIButton!
    
    @IBAction func loginBtn(_ sender: UIButton) {
        if loginField.text == "root" && passwordField.text == "root"{
            self.performSegue(withIdentifier: "affTabSegue", sender: self)
        } else {
            Alert(title: "Error 👨🏻‍🔬 ", message: "Bad login/password, try again 💪🏼")
        }
    }
    
    @IBAction func authentificateID(_ sender: UIButton) {

        let context = LAContext()

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in with Touch ID ") { (successFul, erros) in
                
                if successFul {
                    self.performSegue(withIdentifier: "affTabSegue", sender: self)
                } else {
                    self.Alert(title: "Error 👨🏻‍🔬", message: "Touch ID Authentication Failed 😿")
                }
            }
        } else {
            Alert(title: "Error 👨🏻‍🔬", message: "Touch ID not available. Try to Login ? 🤔")
        }
    }
    
    func Alert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okbutton = UIAlertAction(title: "OK 😭", style: .default, handler: nil)
        alert.addAction(okbutton)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "affTabSegue" {
            if ((segue.destination as? LigandsViewController) != nil) {
                print("Good ONE")
            }
            print("change page", segue.destination)
        }
    }
    
    @IBAction func unwindToAuth(segue: UIStoryboardSegue) {
        print("IM BACK")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginField.layer.masksToBounds = true
        loginField.layer.cornerRadius = 7
        
        passwordField.layer.masksToBounds = true
        passwordField.layer.cornerRadius = 7
        
        //authBtn.layer.masksToBounds = true
        //authBtn.layer.cornerRadius = 5
        
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            authBtn.isHidden = false
        }
        else {
            authBtn.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

