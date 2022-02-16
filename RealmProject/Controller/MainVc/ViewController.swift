//
//  ViewController.swift
//  RealmProject
//
//  Created by Василий  on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var rowsToDisplay: [PersonModel] = []
    var birthdaysPeople: [PersonModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        birthdaysPeople = [ PersonModel(name: "Василий", surname: "Чистяков", birthdayDate: "15.04.1996"),
                            PersonModel(name: "Лариса", surname: "Гагуева", birthdayDate: "06.08.1997"),
                            PersonModel(name: "Никита", surname: "Мелехин", birthdayDate: "02.11.1996")
            ]
        
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
            rowsToDisplay = birthdaysPeople
        case 1 :
            rowsToDisplay = birthdaysPeople.dropLast()
        default:
            break
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
                self.birthdaysPeople.append(person)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.surnameLabel.text = rowsToDisplay[indexPath.row].surname
        cell.nameLabel.text = rowsToDisplay[indexPath.row].name
        cell.birthdayLabel.text = "\(rowsToDisplay[indexPath.row].birthdayDate)"
        
        return cell
    }
}
