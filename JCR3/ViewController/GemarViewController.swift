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
    @objc dynamic var date: String = ""
    @objc dynamic var ayat: String = ""
    @objc dynamic var rhema: String = ""
    
    init(date: String, ayat: String, rhema: String) {
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
    
    func getSate(){
        /*
         If you have time, uncomment the commented part and add some logic to reload database as user scrolls down instead of doing it at once.
         */
        let uuid = Auth.auth().currentUser?.uid
        Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                for s in snapshot.children.allObjects as! [DataSnapshot]{
                    let str = (s.value as! String)
                    let range = str.index(after: str.startIndex)..<str.index(before: str.endIndex)
                    let items = str[range].components(separatedBy:",")
                    self.datasource.append(GemarEntry(date:items[0], ayat: items[1], rhema: items[2]))
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
}

extension GemarViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sate_cell", for:indexPath)
        cell.textLabel?.text = " \(datasource[indexPath.row].date)\n\(datasource[indexPath.row].ayat) "
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //open screen where we can see item info and delete
        let item = datasource[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "entryGemarVC") as? EntryGemarViewController else{
            return
        }
        vc.item = item
        vc.completionHandler = {
            [weak self] in self?.refresh()
        }
        navigationController?.pushViewController(vc, animated: true)
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
        print("call refresh")
        getSate()
        gemarTable.reloadData()
    }
}
