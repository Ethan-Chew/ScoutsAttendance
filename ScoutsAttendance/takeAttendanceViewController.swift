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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath)
        print(cell.textLabel?.text)
        if let text = cell.textLabel?.text {
            attendanceData[text] = []
            name = text
            nameLabel.text = text
            if let reason = reasonField.text {
                if !(reason == "") {
                    personReason = reason
                }
            }
            reasonView.isHidden = false
        }
    }
    
    @IBAction func segmentedCtrl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            personAttendance = "Canceled"
            personReason = "Canceled"
        case 1:
            personAttendance = "Late"
        case 2:
            personAttendance = "Absent"
        default:
            fatalError("Error.")
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let reason = reasonField.text {
            if !(reason == "") {
                personReason = reason
            }
        }
        if personAttendance != "" && personReason != "" {
            attendanceData[name] = [personAttendance, personReason]
            reasonView.isHidden = true
            tableView.reloadData()
        } else if personAttendance != "Canceled" && personReason != "Canceled" {
            attendanceData.removeValue(forKey: name)
        } else {
            saveBtn.titleLabel?.text = "Please Enter a Reason."
        }
        
        for i in 0...attendanceData.count {
            let temp = attendanceData[patrolData[i]]
            print(temp)
        }
    }

    // Variables
    let userDefaults = UserDefaults.standard
    var patrol = ""
    var patrolData:[String] = []
    var attendanceData:[String:[String]] = [:]
    var absentLate = 0
    var personAttendance = ""
    var personReason = ""
    var name = ""
    
    // Labels
    @IBOutlet weak var patrolName: UILabel!
    @IBOutlet weak var tStrength: UILabel!
    @IBOutlet weak var cStrength: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tapGuesture: UITapGestureRecognizer!
    
    // Reason View
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attendance: UISegmentedControl!
    @IBOutlet weak var reasonField: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Config Table View
        tableView.dataSource = self
        tableView.delegate = self
        
        // Edit Reason
        reasonView.clipsToBounds = true
        reasonView.layer.cornerRadius = 12
        reasonView.isHidden = true
        
        // Data
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
        tStrength.text = "Total Strength: \(String(patrolData.count))"
        cStrength.text = "Current Strength: \(String(patrolData.count - absentLate))"
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        cStrength.text = "Current Strength: \(String(patrolData.count - absentLate))"
    }
}
