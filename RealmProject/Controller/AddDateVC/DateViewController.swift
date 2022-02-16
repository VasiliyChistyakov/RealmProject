//
//  DateViewController.swift
//  RealmProject
//
//  Created by Василий  on 16.02.2022.
//

import UIKit

class DateViewController: UIViewController {
    
    var compliton: ((PersonModel) -> ())?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func savePerson(_ sender: Any) {
        getDataAndBack()
    }
    
    func getDataAndBack() {
        guard let name = nameTextField.text ,let surname = surnameTextField.text ,let date = dateTextField.text else { return }
        
        if !name.isEmpty && !surname.isEmpty && !date.isEmpty {
            let person = PersonModel(name: name, surname: surnameTextField.text!, birthdayDate: dateTextField.text!)
            compliton?(person)
            navigationController?.popViewController(animated: true)
        }
    }
}

