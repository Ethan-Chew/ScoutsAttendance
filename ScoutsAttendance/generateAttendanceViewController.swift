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
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    // Variables
    let userDefaults = UserDefaults.standard
    var patrol = ""
    var attendance:[String:[String]] = [:]
    
    // UI Elements
    @IBOutlet weak var patrolLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
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
