//
//  ViewController.swift
//  RealmProject
//
//  Created by Василий  on 16.02.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var rowsToDisplay: Results<PersonModel>!
    var birthdaysPeople: Results<PersonModel>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        birthdaysPeople = realm.objects(PersonModel.self)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func sementedControlAction(_ sender: UISegmentedControl) {
        
                switch segmentedControl.selectedSegmentIndex {
                    
                case 0 :
                    rowsToDisplay = birthdaysPeople.sorted(byKeyPath: "name", ascending: true)
                case 1 :
                    rowsToDisplay = birthdaysPeople.sorted(byKeyPath: "birthdayDate", ascending: true)
                        
                default:
                    rowsToDisplay = birthdaysPeople.sorted(byKeyPath: "name", ascending: true)
                }
        
                self.tableView.reloadData()
    }
    @IBAction func addToDate(_ sender: Any) {
        performSegue(withIdentifier: "AddToDateVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddToDateVC" {
            let vc = segue.destination as! DateViewController
            vc.compliton = { person in
                try! realm.write({
                    realm.add(person)
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.surnameLabel.text = rowsToDisplay[indexPath.row].surname
        cell.nameLabel.text = rowsToDisplay[indexPath.row].name
        cell.birthdayLabel.text = "\(rowsToDisplay[indexPath.row].birthdayDate)"
        
        return cell
    }
}
