//
//  Utilities.swift
//  JCR3
//
//  Created by Irenna Nicole on 24/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class Utilities{
    
    //TODO: check regex.
    /**
         - Password has to be at least 8 characters
         - Contains a character, a number, a special character
     */
    //todo bikin button feedback after button dipencet
    
    static func getFormattedDate(desiredFormat: String) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = desiredFormat
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    static func isAStrongPassword(password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
            "^(?=.*[a-z])(?=.*[$@$#!%*?&])(A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with:password)
    }
    
    static func styleButton(btn: UIButton){
        btn.layer.cornerRadius = 10
    }
    // TODO: check phoneNumber
    static func initiateBackground(imageName: String, view: UIViewController) {
        let backgroundImage = UIImage.init(named: imageName)
        let backgroundImageView = UIImageView.init(frame: view.view.frame)

        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill

        view.view.insertSubview(backgroundImageView, at: 0)
    }
    
    static func requestPengerja(){
        // request pengerja
        let uuid = Auth.auth().currentUser?.uid
        Database.database().reference().child("User/\(uuid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? NSMutableDictionary
            data?["Request"] = 1
            Database.database().reference().child("User/\(uuid!)").setValue(data)
            let currentUser = Auth.auth().currentUser!
            
            let idAccount = data?["IDAccount"] as! NSString
            let dataRequestPengerja = [idAccount: "[\(idAccount), \(currentUser.displayName ?? "nama"), \(currentUser.phoneNumber ?? "number"), \(currentUser.email ?? "email"), Request, \(Utilities.getFormattedDate(desiredFormat: "MM/dd/yyyy HH:mm:ss"))]"]
            Database.database().reference().child("RequestPengerja/Request").setValue(dataRequestPengerja)
        }) {(error) in
                print("error")
                print(error.localizedDescription)
            }
        // tambahin ke JCR3console
        // todo: ksh feedback ke user
    }
    
    
    /* buat kalo perlu picker lagi
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int {
        return pickerData.count
    }
    // The data to return fopr the row and component (column) that's being passed in
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return pickerData[row]
      }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("component: \(component)")
        print("row: \(row)")
    }
    */
    
    /* Kalo perlu async function
     
     let photoUrl = Auth.auth().currentUser?.photoURL
     
     DispatchQueue.global().async {
         let photo = try? Data(contentsOf: photoUrl!) as NSData
         DispatchQueue.main.async {
             //print(UIImage(data: photo!.base64EncodedData()))
             //let base64:String = (photo?.base64EncodedString())!
             //let dataDecoded:NSData = NSData(base64Encoded: base64, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
             //print(dataDecoded)
             print(photo!)
             self.profilePic.image = UIImage(data: photo! as Data, scale:1.0)
         }
     }
     */
}
