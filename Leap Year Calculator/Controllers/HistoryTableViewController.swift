//
//  HistoryViewController.swift
//  Leap Year Calculator
//
//  Created by Kadir Emre on 12.05.2021.
//

import UIKit
import RealmSwift
class HistoryTableViewController : UITableViewController{
    
    var savedYears : Results<LeapYear>?
    let realm = try! Realm()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        loadYears()
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = "\(savedYears![indexPath.row].year)"
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return savedYears?.count ?? 0
    }
    
    //MARK: - Delete Button Functionality
    
    @IBAction func deleteBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.visibleCells.isEmpty{
            return
        }else{
            deletionAlert()
        }
        
    }
    
    //MARK: - Data Manipulation Methods
    func loadYears(){
        savedYears = realm.objects(LeapYear.self)
        tableView.reloadData()
    }
    
    func deleteYears(){
        
        try! realm.write {
            realm.delete(savedYears!)
        }
        tableView.reloadData()
    }
    
    //MARK: - Alert Creation
    
    func deletionAlert(){
        let alert = UIAlertController(title: "WARNING!", message: "You're about to delete all of your history. Are you sure?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteYears()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil )
    }
}
