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

    @IBOutlet weak var NavBar: UINavigationBar!
    @IBOutlet weak var NavBarLbl: UINavigationItem!
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
    
    @IBAction func simpanBtnTapped(_ sender: Any) {
        let uuid = Auth.auth().currentUser?.uid
        var fields = ["IDAccount": idAccountTxt.text?.trimmingCharacters(in: .whitespaces), "Role": statusTxt.text?.trimmingCharacters(in: .whitespaces), "Number": noHpTxt.text?.trimmingCharacters(in: .whitespaces), "Name": namaTxt.text?.trimmingCharacters(in: .whitespaces), "Email" :emailTxt.text?.trimmingCharacters(in: .whitespaces), "Church": gerejaTxt.text?.trimmingCharacters(in: .whitespaces), "Uid": uuid]
        Database.database().reference().child("Account/\(uuid!)").setValue(fields)
    }
    
    @IBAction func requestPengerjaTapped(_ sender: Any) {
        Utilities.requestPengerja()
    }
    
}
