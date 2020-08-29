//
//  BacaRenunganViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 25/08/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BacaRenunganViewController: UIViewController {

    @IBOutlet weak var isiAyatLbl: UILabel!
    @IBOutlet weak var ayatLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var renunganTableView: UITableView!
    @IBOutlet weak var logoJC: UIImageView!
    @IBOutlet weak var buatGematBtn: UIButton!
    @IBOutlet weak var renunganTitleLbl: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var renunganTextLbl: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var ayatHarianView: UIView!
    @IBOutlet weak var quotesHarianView: UIView!
    
     var datasource = [GemarEntry]()
    
    // TODO: replace popupview with UIAlertController instead
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRenungan()
        renunganTableView.delegate = self
        renunganTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleView(v: ayatHarianView)
        Utilities.styleView(v: quotesHarianView)
    }
    
    // show share popup
    @IBAction func btnShareTapped(_ sender: Any) {
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
    }
    
    func getRenungan(){
        /*
         TODO: change firebase address
         */
        let uuid = Auth.auth().currentUser?.uid
        Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for s in snapshot.children.allObjects as! [DataSnapshot]{
                    let str = (s.value as! String)
                    let range = str.index(after: str.startIndex)..<str.index(before: str.endIndex)
                    let items = str[range].components(separatedBy:", ")
                    self.datasource.append(GemarEntry(key:s.key, date:items[0], ayat: items[1], rhema: items[2]))
                }
                self.renunganTableView.reloadData()
            }
        }){(error) in
            print(error.localizedDescription)
        }
    }
}

class RenunganTableViewCell: UITableViewCell{
    
    override func prepareForReuse() {
        //clear cell
        for i in (0..<self.subviews.count).reversed() {
            self.subviews[i].removeFromSuperview()
        }
    }
}

extension BacaRenunganViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "renungan_cell", for:indexPath) as! RenunganTableViewCell
        
        //image
         let imageView:UIImageView = {
             let iv = UIImageView()
             iv.image = UIImage(named: "noted")
             iv.contentMode = .scaleAspectFill
             iv.layer.masksToBounds = true
             return iv
         }()
         // tanggal
         let dateLbl: UILabel = {
             let lbl = UILabel()
             lbl.text = datasource[indexPath.row].date
             lbl.font = UIFont.systemFont(ofSize: 14)
             lbl.numberOfLines = 1
             return lbl
         }()
         
         //ayat
        let ayatLbl: UILabel = {
             let lbl = UILabel()
             lbl.text = datasource[indexPath.row].ayat
             lbl.font = UIFont.systemFont(ofSize: 14)
             lbl.textColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
             lbl.numberOfLines = 1
             return lbl
         }()
         
         cell.addSubview(imageView)
         cell.addSubview(dateLbl)
         cell.addSubview(ayatLbl)
    
         imageView.frame = CGRect(x: 20, y: 5, width: 40, height: 40)
         dateLbl.frame = CGRect(x: 70, y: 5, width: self.view.frame.width - 90 , height: 25)
         ayatLbl.frame = CGRect(x: 70, y: 25, width: self.view.frame.width - 90 , height: 25)
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Action 1: redirect to gemar entry
        let openGemarEntry = UIAlertAction(title: "Buat Gemar", style: .default) { (action:UIAlertAction) in
            let item = self.datasource[indexPath.row]
            guard let vc = self.storyboard?.instantiateViewController(identifier: "entryGemarVC") as? EntryGemarViewController else{
               return
           }
           vc.item = item
           vc.completionHandler = {
               [weak self] in self?.refresh()
           }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // action2: cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            //do nothing
        }
        
        let alertController = UIAlertController(title: datasource[indexPath.row].ayat, message: datasource[indexPath.row].rhema, preferredStyle: .alert)
        alertController.addAction(openGemarEntry)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func refresh(){
        self.datasource = []
        getRenungan()
        renunganTableView.reloadData()
    }
}
