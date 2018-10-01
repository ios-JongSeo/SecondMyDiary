//
//  TimelineViewController.swift
//  SecondMyDiary
//
//  Created by 김종서 on 2018. 9. 21..
//  Copyright © 2018년 김종서. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var environment: Environment!
    private var entries: [Entry] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
            entryVC?.environment = environment
            
        case "showEntry":
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = tableView.indexPathForSelectedRow {
                entryVC.environment = environment
                let entry = entries[selectedIndexPath.row]
                entryVC.editingEntry = entry
            }
        
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SecondMyDiary"
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        entries = environment.entryRepository.recentEntries(max: environment.entryRepository.numberOfEntries)
        tableView.reloadData()
    }
}

extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return environment.entryRepository.numberOfEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath)
        
        let entry = entries[indexPath.row]
        
        tableViewCell.textLabel?.text = entry.text
        tableViewCell.detailTextLabel?.text = DateFormatter.entryDateFormatter.string(from: entry.createdAt)
        
        return tableViewCell
    }
}
