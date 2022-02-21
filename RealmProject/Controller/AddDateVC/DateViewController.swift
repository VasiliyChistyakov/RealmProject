//
//  DateViewController.swift
//  RealmProject
//
//  Created by Василий  on 16.02.2022.
//

import UIKit

class DateViewController: UIViewController {
    
    let dateFormater = DateFormatter()
    var compliton: ((PersonModel) -> ())?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormater.dateFormat = "dd.MM.yy"
    }
    
    
    @IBAction func savePerson(_ sender: Any) {
        getDataAndBack()
    }
    
    func getDataAndBack() {
        guard let name = nameTextField.text ,let surname = surnameTextField.text ,let date = dateTextField.text else { return }
        if !name.isEmpty && !surname.isEmpty && !date.isEmpty {
            guard let fetchDate = dateFormater.date(from: date) else { return }
            let person = PersonModel(value: ["\(name)", "\(surname)", fetchDate])
            compliton?(person)
            navigationController?.popViewController(animated: true)
        }
    }
}

