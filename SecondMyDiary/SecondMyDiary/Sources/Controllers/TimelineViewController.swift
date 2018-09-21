//
//  TimelineViewController.swift
//  SecondMyDiary
//
//  Created by 김종서 on 2018. 9. 21..
//  Copyright © 2018년 김종서. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var entryCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "SecondMyDiary"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        let journal = InMemoryEntryRepository.shared
        
        entryCountLabel.text = journal.numberOfEntries > 0
            ? "엔트리 갯수: \(journal.numberOfEntries)"
            : "엔트리 없음"
    }
}
