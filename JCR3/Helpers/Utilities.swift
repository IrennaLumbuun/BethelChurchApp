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
    
    static func styleCircularButton(btn: UIButton){
        //border
        btn.layer.cornerRadius = btn.frame.height/2
        
        //shadow
        btn.backgroundColor = UIColor(red: 192, green: 192, blue: 192, alpha:1)
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 1.0
        btn.layer.masksToBounds = false
    }
    
    static func styleRectangularButton(btn: UIButton){
        //border
        btn.layer.cornerRadius = 10
        
        //shadow
        btn.backgroundColor = UIColor(red: 192, green: 192, blue: 192, alpha:1)
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        btn.layer.shadowOpacity = 1.0
        btn.layer.shadowRadius = 1.0
        btn.layer.masksToBounds = false
    }
    
    static func makeCircular(imgView: UIImageView, color:CGColor){
        //border
        imgView.layer.cornerRadius = imgView.frame.height/2
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = color
    }
    
    static func styleView(v:UIView){
        //border
        v.layer.cornerRadius = 10
        
        //shadow
        v.backgroundColor = UIColor(red: 192, green: 192, blue: 192, alpha:1)
        v.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        v.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        v.layer.shadowOpacity = 1.0
        v.layer.shadowRadius = 1.0
        v.layer.masksToBounds = false
    }
    
    // TODO: check phoneNumber
    static func initiateBackground(imageName: String, view: UIViewController) {
        let backgroundImage = UIImage.init(named: imageName)
        let backgroundImageView = UIImageView.init(frame: view.view.frame)

        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill

        view.view.insertSubview(backgroundImageView, at: 0)
    }
    
    //show user that button is clicked
    static func onClickFeedback(btn:UIButton){
        btn.alpha = 0.7
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            btn.alpha = 1
        }
    }
    
    //convert image to black and white
    static func convertToGrayScale(image: UIImage) -> UIImage {

        // Create image rectangle with current image width/height
        let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)

        // Grayscale color space
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = image.size.width
        let height = image.size.height

        // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

        // Draw image into current context, with specified rectangle
        // using previously defined context (with grayscale colorspace)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        context?.draw(image.cgImage!, in: imageRect)
        let imageRef = context!.makeImage()

        // Create a new UIImage object
        let newImage = UIImage(cgImage: imageRef!)

        return newImage
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
    
    static func displayShareController(message: String, sender: UIView, viewController: UIViewController){
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        
        // ipad config
        activityViewController.popoverPresentationController?.sourceView = sender
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        
        
        //pre - configuration
        activityViewController.activityItemsConfiguration = [ UIActivity.ActivityType.message] as? UIActivityItemsConfigurationReading
        
        viewController.present(activityViewController, animated: true)
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
