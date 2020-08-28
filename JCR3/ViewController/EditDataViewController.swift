//
//  EditDataViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditDataViewController: UIViewController {

    @IBOutlet weak var idAccountTxt: UITextField!
    @IBOutlet weak var statusTxt: UITextField!
    @IBOutlet weak var noHpTxt: UITextField!
    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var gerejaTxt: UITextField!
    @IBOutlet weak var simpanBtn: UIButton!
    @IBOutlet weak var requestPengerjaBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleView(v: idAccountTxt)
        Utilities.styleView(v: statusTxt)
        Utilities.styleView(v: noHpTxt)
        Utilities.styleView(v: namaTxt)
        Utilities.styleView(v: emailTxt)
        Utilities.styleView(v: gerejaTxt)
        Utilities.styleRectangularButton(btn: simpanBtn)
        Utilities.styleRectangularButton(btn: requestPengerjaBtn)
        requestPengerjaBtn.backgroundColor = UIColor.red
        simpanBtn.backgroundColor = UIColor(red: 67/255, green: 122/255, blue: 77/255, alpha: 1.0)
    }
    
    func setup(){
        let uuid = Auth.auth().currentUser?.uid
        Database.database().reference().child("User/\(uuid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? NSDictionary
            let id = data?["IDAccount"] as? String ?? ""
            let status = data?["Role"] as? String ?? ""
            let number = data?["Number"] as? String ?? ""
            let email = data?["Email"] as? String ?? ""
            let gereja = data?["Church"] as? String ?? ""
            let nama = data?["Name"] as? String ?? ""
            self.idAccountTxt.text = id
            self.statusTxt.text = status
            self.noHpTxt.text = number
            self.namaTxt.text = nama
            self.emailTxt.text = email
            self.gerejaTxt.text = gereja
        }) {(error) in
                print("error")
                print(error.localizedDescription)
            }
    }
    
    func transitionToUserProfile(){
        //transition to home
        let userProfileVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.userProfileViewController) as? UserProfileViewController
        
        userProfileVC?.modalPresentationStyle = .fullScreen
        userProfileVC?.modalTransitionStyle = .coverVertical
        present(userProfileVC!, animated: true, completion: nil)
    }
    
    @IBAction func simpanBtnTapped(_ sender: Any) {
        // transition to home when button is pressed
        let exitControllerAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
             self.navigationController?.popViewController(animated: true)
            print("You've pressed default");
        }
        
        let uuid = Auth.auth().currentUser?.uid
        let fields = ["IDAccount": idAccountTxt.text?.trimmingCharacters(in: .whitespaces), "Role": statusTxt.text?.trimmingCharacters(in: .whitespaces), "Number": noHpTxt.text?.trimmingCharacters(in: .whitespaces), "Name": namaTxt.text, "Email" :emailTxt.text?.trimmingCharacters(in: .whitespaces), "Church": gerejaTxt.text?.trimmingCharacters(in: .whitespaces), "Uid": uuid]
        Database.database().reference().child("User/\(uuid!)").setValue(fields){
          (error:Error?, ref:DatabaseReference) in
          if let error = error {
            // show error
            let alertController = UIAlertController(title: "Error saving data", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(exitControllerAction)
            self.present(alertController, animated: true, completion: nil)
            //exit editDataVC
          } else {
            // submit changes to firebase auth
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.namaTxt.text
            changeRequest?.commitChanges(completion: { (error) in
                let alertController = UIAlertController(title: "Error saving data", message: error?.localizedDescription, preferredStyle: .alert)
                alertController.addAction(exitControllerAction)
                self.present(alertController, animated: true, completion: nil)
            })
            let alertController = UIAlertController(title: "Pesan dari server", message: "Your data has been updated.", preferredStyle: .alert)
            alertController.addAction(exitControllerAction)
            self.present(alertController, animated: true, completion: nil)
          }
        }
        
        
    }
    
    @IBAction func requestPengerjaTapped(_ sender: Any) {
        Utilities.requestPengerja()
    }
    
}
