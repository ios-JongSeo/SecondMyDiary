//
//  ViewController.swift
//  SecondMyDiary
//
//  Created by 김종서 on 2018. 9. 10..
//  Copyright © 2018년 김종서. All rights reserved.
//

import UIKit

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
}

class EntryViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let journal: secondMyDiary = InMemoryDiary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "TextView"
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let entry: Entry = Entry(text: textView.text)
        journal.add(entry)
    }
}

