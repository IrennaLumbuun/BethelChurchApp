//
//  DaftarViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 25/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DaftarViewController: UIViewController {

    @IBOutlet weak var namaTxt: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        print("in daftar")

        // Do any additional setup after loading the view.
    }

    func setup(){
        errorLbl.alpha = 0
        Utilities.initiateBackground(imageName: "welcome.jpg", view: self)
    }
    
    func validateFields() -> String? {
        if namaTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Semua textbox harus diisi"
        }
        return nil
    }
    
    //check 56:40
    @IBAction func simpanBtn(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            errorLbl.text = error
            errorLbl.alpha = 1
        } else{
            storeUserToDatabase()
            self.transitionToHome()
            }
        }
    
    func transitionToHome(){
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    func storeUserToDatabase(){
        let name = namaTxt.text
        let userID = Auth.auth().currentUser!.uid
        let userEmail = Auth.auth().currentUser!.email
        let userPhone = Auth.auth().currentUser!.phoneNumber
        print(name!.startIndex)
        print(name!.lowercased()[name!.startIndex])
        let urlId = self.getProfilePic(c: name!.lowercased()[name!.startIndex] ?? "x")
        // calculate IdAccount ddmmyyHHmmss
        let IDAccount = Utilities.getFormattedDate(desiredFormat: "ddMMyyHHmmss")
        let field: [String : Any] = ["Church": "", "Cool": "", "Email" : userEmail ?? "", "Foto" : urlId, "Role": "Jemaat", "Number": userPhone ?? "", "Name": name!, "Uid": userID, "IDAccount": "JCR3" + IDAccount, "Request": 0]

        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = URL(string: "https://drive.google.com/file/d/\(urlId)/view")
        print(urlId)
        changeRequest?.commitChanges(completion: { (error) in
            if error != nil{
                print(error!)
            }
        })
        Database.database().reference().child("User/\(userID)").setValue(field)
    }
    
    // get a link to profile picture based on the first letter of user's name
    // only pass in lowercase letters
    func getProfilePic(c: Character) -> String {
        print(c)
        var id = ""
        switch c {
        case "a":
            id = "1JVTBoPpPo01REGcfa6ZZD3-bfy9l3e0D"
        case "b":
            id = "1e02uYcCKRgAScNHhR8bvaOSp2L1fPHXp"
        case "c":
            id = "1O8cfYfdJR0gDTCx2NW30TE69-tvmfDVp"
        case "d":
            id = "1FuvhYzVZtSo5y3PrGcqkiDz2WMJYlEkZ"
        case "e":
            id = "1xd0ci08wXIoVJSVgwPn4IfjvlXHzuUkV"
        case "f":
            id = "15f85vHlj9RYltHoKFi01moQ7VKadvrV8"
        case "g":
            id = "1b-RT1FJ1EWu0M3-SAM1Yx5JVjMAfrOTx"
        case "h":
            id = "1cGEEkT6Z_0pufkZ5FlZdFiVDgP-uavZK"
        case "i":
            id = "1XFBmOfBz1By2Kxf7tk1YvIxvuEB3yPSm"
        case "j":
            id = "1hHHy4RNPj9ukzFCb3UQz8wCD45eMu_Rr"
        case "k":
            id = "hKt4zK7aVMQbvepsOmruGhGKO9p74zCH"
        case "l":
            id = "1zD-3xZV5TSZq8WGwN0uCVmCBMGHaNPJn"
        case "m":
            id = "1QwQLyLmvuzEJYLaWiO2mxNTE38fTHflC"
        case "n":
            id = "1bw1ZZX8FzOGZX2v3RiSkVn4NLZpFGuFw"
        case "o":
            id = "1BGNVzwOQoePlrGdkw3t7ooTWlzHLoxJQ"
        case "p":
            id = "1zL3x4itzL-_zfb0uI8qUw1vOPypNI4ak"
        case "q":
            id = "11J3bB1StMeSrVViOlq4197d5AkiyaX92"
        case "r":
            id = "1qRbfHge4pjU6zwpHgJLBNcYTDVoHN0Iq"
        case "s":
            id = "1U_2Zbf6-vdMA5XhGfpopFonF1J64OuJJ"
        case "t":
            id = "14MOdpWwfpCLTBGS5DRsxQw_6QWqu0LxC"
        case "u":
            id = "1z87v7YteTHkTIowGEj5ofg-f5th2mTGc"
        case "v":
            id = "1jyRMcl10Wqvc5M_2k7JQUAxTyMihTzJr"
        case "w":
            id = "1ycz58nZRmsqGEOxCfbPySinR4akerpof"
        case "x":
            id = "1dVf9DgIcTJ46ay14qXOnbfaNrrsMj5qs"
        case "y":
            id = "1VqTiOiZttU7fi7j3T3TCRmO3WQh9m2oH"
        case "z":
            id = "1AT-vpkDeNSPPhKLU3sH6ogf7Mbd_mvmI"
        default:
            errorLbl.text = "Fail to retrieve a default profile picture"
            errorLbl.alpha = 1
        }
        return id
    }
}
