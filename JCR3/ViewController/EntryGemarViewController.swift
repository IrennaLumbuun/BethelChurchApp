//
//  EntryGemarViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 30/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EntryGemarViewController: UIViewController {
    
    //outlet
    @IBOutlet weak var simpanBtn: UIBarButtonItem!
    @IBOutlet weak var tanggalLbl: UILabel!
    @IBOutlet weak var ayatTxt: UITextField!
    @IBOutlet weak var rhemaTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        renderLabel()
        styleElement()
    }
    func renderLabel(){
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy"
        let formattedDate = format.string(from: date)
        tanggalLbl.text = formattedDate
    }
    func styleElement(){
        self.rhemaTxt.frame.size.height = self.view.frame.height - tanggalLbl.frame.height - ayatTxt.frame.height - 100
    }
    
    // TODO: reformat ikutin ko Anton
    @IBAction func simpanBtnTapped(_ sender: Any) {
        let uuid = Auth.auth().currentUser?.uid
        let data = [Utilities.getFormattedDate(desiredFormat: "MMddyyyyHHmmss"): "[\(Utilities.getFormattedDate(desiredFormat: "dd MMMM yyyy")), \(ayatTxt.text ?? ""), \(rhemaTxt.text ?? "")]"]
        Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").setValue(data)
        
        /* Uncomment this if ko anton agrees to rearrange databaseappend entry to a list of entries
        Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            var data = snapshot.value as? Array<Any>
            if data == nil{
                data = [entry]
            } else {
                data?.append(entry)
            }
            Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").setValue(data!)
            self.ayatTxt.text = ""
            self.rhemaTxt.text = ""
           }) {(error) in
                   print(error.localizedDescription)
               }*/
    }
    
}
