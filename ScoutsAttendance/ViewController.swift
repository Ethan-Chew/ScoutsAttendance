//
//  ViewController.swift
//  ScoutsAttendance
//
//  Created by Ethan Chew on 14/5/21.
//

import UIKit
import CoreXLSX

class ViewController: UIViewController {
    
    // Variables
    let userDefaults = UserDefaults.standard
    var didFirstOpen = false
    var exa:[String] = []
    var nano:[String] = []
    var tera:[String] = []
    var zetta:[String] = []
    
    // Buttons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fo = userDefaults.bool(forKey: "First Open") as? Bool {
            didFirstOpen = fo
        }
//        didFirstOpen = false
        
        // Get Data
        if (!didFirstOpen) {
            let patrols = ["EXA", "NANO", "TERA", "ZETTA"]
            do {
                let filepath = Bundle.main.path(forResource: "Scouts Attendance Data", ofType: "xlsx")!
                
                guard let file = XLSXFile(filepath: filepath) else {
                    fatalError("XLSX file at \(filepath) is corrupted or does not exist")
                }
                
                for wbk in try file.parseWorkbooks() {
                    guard let path = try file.parseWorksheetPathsAndNames(workbook: wbk)
                            .first(where: { $0.name == "Sheet1" }).map({ $0.path })
                    else { continue }
                    
                    let sharedStrings = try file.parseSharedStrings()
                    let worksheet = try file.parseWorksheet(at: path)
                    
                    // Get Cell Data
                    let patrolNames = worksheet.cells(atColumns: [ColumnReference("B")!])
                        .compactMap { $0.stringValue(sharedStrings!) }
                    for i in 0...patrols.count - 1 {
                        let startRow = patrolNames.firstIndex(of: patrols[i]) ?? 0
                        let endRow = patrolNames.lastIndex(of: patrols[i]) ?? 0
                       
                        
                        var index = 0
                        for _ in Int(startRow)...Int(endRow) {
                            if (startRow + index <= endRow) {
                                let parseData = worksheet.cells(atRows: [UInt(startRow + index)])
                                    .compactMap { $0.stringValue(sharedStrings!) }
                                var name = ""
                                if (!parseData.isEmpty) {name = parseData[0] }
                                switch patrols[i] {
                                case "EXA":
                                    exa.append(name)
                                case "NANO":
                                    nano.append(name)
                                case "TERA":
                                    tera.append(name)
                                case "ZETTA":
                                    zetta.append(name)
                                default:
                                    fatalError("Unknown Patrol")
                                }
                            }
                            index += 1
                        }
                    }
                    
                }
            } catch {
                fatalError("\(error.localizedDescription)")
            }
            userDefaults.set(exa, forKey: "Exa")
            userDefaults.set(nano, forKey: "Nano")
            userDefaults.set(tera, forKey: "Tera")
            userDefaults.set(zetta, forKey: "Zetta")
            userDefaults.set(true, forKey: "First Open")
        }
    }
    @IBAction func exaBtn(_ sender: Any) {
        userDefaults.set("Exa", forKey: "Chosen Patrol")
    }
    
    @IBAction func nanoBtn(_ sender: Any) {
        userDefaults.set("Nano", forKey: "Chosen Patrol")
    }
    
    @IBAction func teraBtn(_ sender: Any) {
        userDefaults.set("Tera", forKey: "Chosen Patrol")
    }
    
    @IBAction func zettaBtn(_ sender: Any) {
        userDefaults.set("Zetta", forKey: "Chosen Patrol")
    }
    
}

