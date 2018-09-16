//
//  createTaskViewController.swift
//  vaporAlamofire
//
//  Created by Isha on 9/13/18.
//  Copyright © 2018 Isha. All rights reserved.
//

import UIKit
import Alamofire

class createTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var taskDescriptionField: UITextField!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var inCompleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var completionStatus = "false"
    var lastTask = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        taskDescriptionField.delegate = self
        completeButton.layer.borderColor = UIColor.black.cgColor
        inCompleteButton.layer.borderColor = UIColor.black.cgColor
        completeButton.layer.borderWidth = 0.8
        inCompleteButton.layer.borderWidth = 0.8
        setupAddTargetIsNotEmptyTextFields()
    }

    @IBAction func completeButton(_ sender: UIButton) {
        completeButton.layer.backgroundColor = UIColor.gray.cgColor
        inCompleteButton.layer.backgroundColor = UIColor.white.cgColor
        completionStatus = "true"
    }
    
    @IBAction func incompleteButton(_ sender: UIButton) {
        completeButton.layer.backgroundColor = UIColor.white.cgColor
        inCompleteButton.layer.backgroundColor = UIColor.gray.cgColor
        completionStatus = "false"
    }
    
    @IBAction func saveTask(_ sender: UIButton) {
        var id = ""
        if let x = Int(lastTask) {
            id = String(x + 1)
        } else {
            id = String(describing: 1)
        }
        let taskToCreate = tasky(id: id, title: taskDescriptionField.text!, completed: completionStatus)
        let parameters = [
            "id": taskToCreate.id as Any,
            "title" : taskToCreate.title as Any,
            "completed" : taskToCreate.completed as Any] as [String: Any]
       
        Alamofire.request("https://vaporapi-dev.vapor.cloud/create", method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
            switch(response.result) {
                case .success(_):
                print("sucess \(response.result)")

                case .failure(_):
                    print(response.result.error!)
            }
            NotificationCenter.default.post(name: NSNotification.Name("getData"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        saveButton.isEnabled = false
        taskDescriptionField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
            guard
                let description = taskDescriptionField.text, !description.isEmpty
                else {
                    saveButton.isEnabled = false
                    return
            }
            saveButton.isEnabled = true
        
        
    }
}

