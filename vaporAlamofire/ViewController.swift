//
//  ViewController.swift
//  vaporAlamofire
//
//  Created by Isha on 9/13/18.
//  Copyright © 2018 Isha. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allTasks = [tasky]()
    
   @IBOutlet weak var taskTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let getDataNotification = NSNotification.Name("getData")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.changeValues), name: getDataNotification, object: nil)
        displayAllTasks()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTable.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! taskTableViewCell
        cell.aTask = allTasks[indexPath.row]
        return cell
    }
    
    @IBAction func createTask(_ sender: UIButton) {
       performSegue(withIdentifier: "createTask", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createTask" {
            let destination = segue.destination as? createTaskViewController
            guard let x = allTasks.last?.id else {return}
            destination?.lastTask = x
        }
    }
    
    func displayAllTasks() {
        Alamofire.request("https://vaporapi-dev.vapor.cloud/tasks").responseJSON(completionHandler: { response in
            guard let validResponse = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let item = try decoder.decode([tasky].self, from: validResponse)
                print(item)
                if item.count > 0 {
                    self.allTasks = item.sorted{ $0.id  < $1.id }
                    self.taskTable.reloadData()
                }
            } catch {
                print("error trying to decode response")
                print(error)
            }
        })
    }
    
    @objc func changeValues() {
        displayAllTasks()
    }
    

    @IBAction func deleteButton(_ sender: UIButton) {
        let taskID = ["id": "1"] as [String: Any]
        Alamofire.request("https://vaporapi-dev.vapor.cloud/delete", method: .delete, parameters: taskID).responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling DELETE on /todos/1")
                print(response.result.error!)
                return
            }
            print("DELETE ok")
        }
    }
    

}

