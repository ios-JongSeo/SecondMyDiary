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
    @IBOutlet weak var button: UIButton!
    
    let journal: secondMyDiary = InMemoryDiary()
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = "TextView"
        
        button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    @objc func saveEntry(_ sender: Any) {
        if let editing = editingEntry {
            editing.text = textView.text
            journal.update(editing)
        } else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
        }

        updateSubviews(for: false)
    }
    
    @objc func editEntry(_ sender: Any) {
        updateSubviews(for: true)
    }
    
    
    fileprivate func updateSubviews(for isEditing: Bool) {
        if isEditing {
            textView.isEditable = true
            textView.becomeFirstResponder()
            
            button.setTitle("저장", for: .normal)
            button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        } else {
            textView.isEditable = false
            textView.resignFirstResponder()
            
            button.setTitle("수정", for: .normal)
            button.addTarget(self, action: #selector(editEntry(_:)), for: .touchUpInside)
        }
    }

}

