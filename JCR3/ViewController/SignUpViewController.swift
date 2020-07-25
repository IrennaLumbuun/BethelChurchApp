//
//  SignUpViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 23/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var daftarBtn: UIButton!
    
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        errorLbl.alpha = 0
        // TODO: style other elements?
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // check textfields and validate the data is correct
    // return nil if correct
    // return error if not
    func validateFields() -> String?{
        // check all fields are filled in
        if phoneNumberTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Semua textbox harus diisi"
        }
        
        // check if the password is strong
        let password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /* TODO: uncomment & figure out regex
        if Utilities.isAStrongPassword(password: password) == false{
            // password is too weak
            return "Password harus lebih dari 8 digit, minimum satu huruf, satu angka, dan satu simbol (cth: %, $, #, dll)"
        }*/
        return nil
    }
    
    @IBAction func daftarBtnTapped(_ sender: Any) {
        // validate fields
        let error = validateFields()
        if error != nil {
            // show error
            errorLbl.text = error!
            errorLbl.alpha = 1
        } else {
            // create user
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTxt.text!, uiDelegate: nil) { (verificationID, error) in
                if error == nil{
                    print(verificationID)
                    // transition to home screen?
                } else {
                        self.errorLbl.text = error?.localizedDescription
                        self.errorLbl.alpha = 1
                      return
                    }
            }
            // transition to home screen
        }
    }
}
