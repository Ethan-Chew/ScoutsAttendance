//
//  generateAttendanceViewController.swift
//  ScoutsAttendance
//
//  Created by Ethan Chew on 17/5/21.
//

import UIKit

class generateAttendanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table View Stub
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        let currData = attendance[names[indexPath.row]]
        
        cell.textLabel?.text = names[indexPath.row]
        if currData == ["Present",""] {
            cell.detailTextLabel?.text = "Present"
        } else {
            cell.detailTextLabel?.text = "\(currData![0]) -- \(currData![1])"
        }
        if currData![0] == "Absent" || currData![0] == "Late" {
            absentee += 1
            cs.text = "Current Strength: \(attendance.count - Int(absentee))"
        }
        return cell
    }
    
    // Variables
    let userDefaults = UserDefaults.standard
    var patrol = ""
    var attendance:[String:[String]] = [:]
    var names:[String] = []
    var absentee = 0
    
    // UI Elements
    @IBOutlet weak var patrolLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ts: UILabel!
    @IBOutlet weak var cs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Config Table View
        tableView.dataSource = self
        tableView.delegate = self
        
        // User Defaults
        if let name = userDefaults.string(forKey: "Chosen Patrol") {
            patrol = name
            patrolLabel.text = patrol
        }
        if let data = userDefaults.dictionary(forKey: "Attendance") as? [String:[String]] {
            attendance = data
        }
        
        // Get Names
        names = Array(attendance.keys)
        
        // Check data
        for i in 0...attendance.count - 1 {
            if attendance[names[i]] == ["", ""] {
                attendance[names[i]] = ["Present", ""]
            }
        }
        // Assign Strength
        ts.text = "Total Strength: \(attendance.count)"
        cs.text = "Current Strength: \(attendance.count - Int(absentee))"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
