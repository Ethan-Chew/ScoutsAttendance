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
        name = patrolData[indexPath.row]
        nameLabel.text = name
        if let reason = reasonField.text {
            if !(reason == "") {
                personReason = reason
            }
        }
        reasonView.isHidden = false
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
            if (reason != "" || reason != "Enter Reason") {
                personReason = reason
            }
        }
        
        if (personAttendance == "Canceled") {
            reasonView.isHidden = true
        } else {
            if (personReason == "Enter Reason") {
                saveBtn.titleLabel?.text = "Enter a Reason"
            } else {
                attendanceData[name] = [personAttendance, personReason]
                reasonView.isHidden = true
            }
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generateAttBtn: UIButton!
    
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
        
        // Edit Btn
        generateAttBtn.clipsToBounds = true
        generateAttBtn.layer.cornerRadius = 12
        
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
        
        for i in 0...patrolData.count - 1 {
            attendanceData[patrolData[i]] = ["", ""]
        }
    }

    @IBAction func generateAttendance(_ sender: Any) {
        if name == "" {
            attendanceData.removeValue(forKey: name)
        }
        
        userDefaults.set(attendanceData, forKey: "Attendance")
    }
}
