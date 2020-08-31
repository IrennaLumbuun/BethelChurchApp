//
//  GemarViewController.swift
//  JCR3
//
//  Created by Irenna Nicole on 26/07/20.
//  Copyright © 2020 Irenna Lumbuun. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class GemarEntry {
    @objc dynamic var key: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var ayat: String = ""
    @objc dynamic var rhema: String = ""
    
    init(key: String, date: String, ayat: String, rhema: String) {
        self.key = key
        self.date = date
        self.ayat = ayat
        self.rhema = rhema
    }
}

class GemarViewController: UIViewController {

    @IBOutlet weak var addEntryBtn: UIButton!
    @IBOutlet weak var bacaRenunganBtn: UIButton!
    @IBOutlet weak var gemarTable: UITableView!
    
    var datasource = [GemarEntry]()
    var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSate()
        gemarTable.delegate = self
        gemarTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        Utilities.styleRectangularButton(btn: bacaRenunganBtn)
        Utilities.styleRectangularButton(btn: addEntryBtn)
        bacaRenunganBtn.backgroundColor = UIColor(red: 199/255, green: 60/255, blue: 22/255, alpha: 1)
        addEntryBtn.backgroundColor = UIColor(red: 2/255, green: 97/255, blue: 48/255, alpha: 1)
    }
    
    func getSate(){
        /*
         If you have time, uncomment the commented part and add some logic to reload database as user scrolls down instead of doing it at once.
         
         //jangan lupa gemar entry sekarang ada key
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
                self.gemarTable.reloadData()
            }
        }){(error) in
            print(error.localizedDescription)
        }
    }
        
        /*if currentIndex == -1 {
            Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount > 0 {
                    for s in snapshot.children.allObjects as! [DataSnapshot]{
                        let str = (s.value as! String)
                        let range = str.index(after: str.startIndex)..<str.index(before: str.endIndex)
                        let items = str[range].components(separatedBy:",")
                        self.datasource.append(GemarEntry(date:items[0], ayat: items[1], rhema: items[2]))
                    }
                    self.currentIndex = 10
                    self.gemarTable.reloadData()
                }
            }){(error) in
                print(error.localizedDescription)
            }
        } //not the first time retrieving data
        else {
            Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").queryLimited(toLast: 11).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount > 0 {
                    for s in snapshot.children.allObjects as! [DataSnapshot]{
                        let str = (s.value as! String)
                        let range = str.index(after: str.startIndex)..<str.index(before: str.endIndex)
                        let items = str[range].components(separatedBy:",")
                        self.datasource.append(GemarEntry(date:items[0], ayat: items[1], rhema: items[2]))
                    }
                    self.currentIndex += 10
                    self.gemarTable.reloadData()
                }
            }){(error) in
                print(error.localizedDescription)
            }
        }
    }*/
    @IBAction func backButtonTapped(_ sender: Any) {
        //transition to home
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        homeVC?.modalPresentationStyle = .fullScreen
        homeVC?.modalTransitionStyle = .coverVertical
        present(homeVC!, animated: true, completion: nil)
    }
}

class GemarTableViewCell: UITableViewCell{
    
    override func prepareForReuse() {
        //clear cell
        for i in (0..<self.subviews.count).reversed() {
            self.subviews[i].removeFromSuperview()
        }
    }
    
}

extension GemarViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "sate_cell", for:indexPath) as! GemarTableViewCell
        
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
        let openGemarEntry = UIAlertAction(title: "Buka Gemar", style: .default) { (action:UIAlertAction) in
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
        
        // action2: delete gemar
        let deleteGemar = UIAlertAction(title: "Delete", style: .destructive) { (action:UIAlertAction) in
            let uuid = Auth.auth().currentUser?.uid
            let ref = Database.database().reference().child("jcsaatteduh/sate/\(uuid!)/\(self.datasource[indexPath.row].key)")
            ref.removeValue(){
                error, _ in
                if let error = error {
                  print("Data could not be deleted: \(error).")
                } else {
                  self.refresh()
                }
            }
        }
        
        // action 3: share gemar
        let shareGemar = UIAlertAction(title: "Share", style: .default) { (action:UIAlertAction) in
            let message = "Shalom On Fire! Ayo Gemar \(Utilities.getFormattedDate(desiredFormat: "dd MM yyyy"))\n *Firman:* \n \(self.datasource[indexPath.row].ayat)\n*Rhema* \n \(self.datasource[indexPath.row].rhema)\n Tuhan Yesus memberkati!"
            Utilities.displayShareController(message: message, sender: tableView, viewController: self)
        }
        
        // action 4: cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            //do nothing
        }
        
        let alertController = UIAlertController(title: datasource[indexPath.row].ayat, message: datasource[indexPath.row].rhema, preferredStyle: .alert)
        alertController.addAction(openGemarEntry)
        alertController.addAction(shareGemar)
        alertController.addAction(deleteGemar)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    /* Uncomment this when adding logic on infinite scrolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maxOffset -  currentOffset <= 40 {
            getSate()
        }
    }*/
    
    func refresh(){
        self.datasource = []
        getSate()
        gemarTable.reloadData()
    }
}
