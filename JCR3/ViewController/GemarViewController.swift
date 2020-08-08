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

class GemarViewController: UIViewController {

    @IBOutlet weak var addEntryBtn: UIButton!
    @IBOutlet weak var bacaRenunganBtn: UIButton!
    @IBOutlet weak var gemarTable: UITableView!
    
    var datasource: Array<Any> = []
    var currentIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSate()
    }
    
    func getSate(){
        let uuid = Auth.auth().currentUser?.uid
        if currentIndex == -1 {
            Database.database().reference().child("jcsaatteduh/sate/\(uuid!)").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.childrenCount > 0 {
                    for s in snapshot.children.allObjects as! [DataSnapshot]{
                        let str = (s.value as! String)
                        let range = str.index(after: str.startIndex)..<str.index(before: str.endIndex)
                        let items = str[range].components(separatedBy:",")
                        self.datasource.append(items)
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
                        self.datasource.append(items)
                    }
                    self.currentIndex += 10
                    self.gemarTable.reloadData()
                }
            }){(error) in
                print(error.localizedDescription)
            }
        }
    }
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
        let entry: Array<String> = self.datasource[indexPath.row] as! Array<String>
        
        print(entry)
        let lblAyat = UILabel(frame: CGRect(x: 10, y: 10, width: self.view.frame.width, height: 20))
        lblAyat.text = entry[1]
        let lblRhema = UILabel(frame: CGRect(x: 10, y: 40, width: self.view.frame.width, height: 20))
        lblRhema.text = entry[2]
        
        cell.addSubview(lblAyat)
        cell.addSubview(lblRhema)
        
        //cell.create(for: entry as! Array<String>)
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maxOffset -  currentOffset <= 40 {
            getSate()
        }
    }
}
