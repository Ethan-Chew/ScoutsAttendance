//
//  takeAttendanceViewController.swift
//  ScoutsAttendance
//
//  Created by Ethan Chew on 14/5/21.
//

import UIKit

class takeAttendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patrolData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath)

        cell.textLabel?.text = patrolData[indexPath.row]
        return cell
    }
    

    // Variables
    let userDefaults = UserDefaults.standard
    var patrol = ""
    var patrolData:[String] = []
    
    // Labels
    @IBOutlet weak var patrolName: UILabel!
    @IBOutlet weak var tStrength: UILabel!
    @IBOutlet weak var cStrength: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if let name = userDefaults.string(forKey: "Chosen Patrol") {
            patrolName.text = name
            patrol = name
        }
        
        switch patrol {
        case "Exa":
            if let data = userDefaults.array(forKey: "Exa") as? [String] {
                patrolData = data
            }
        case "Nano":
            if let data = userDefaults.array(forKey: "Nano") as? [String] {
                patrolData = data
            }
        case "Tera":
            if let data = userDefaults.array(forKey: "Tera") as? [String] {
                patrolData = data
            }
        case "Zetta":
            if let data = userDefaults.array(forKey: "Zetta") as? [String] {
                patrolData = data
            }
        default:
            fatalError("Unknown Patrol")
        }
        tStrength.text = "Total Strength : \(String(patrolData.count))"
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
