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

let code = """
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
"""

class EntryViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    let journal: EntryRepository = InMemoryEntryRepository.shared
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = DateFormatter.entryDateFormatter.string(from: Date())
        textView.text = code
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handleKeyboardAppearance(_:)),
                         name: NSNotification.Name.UIKeyboardWillShow,
                         object: nil)
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handleKeyboardAppearance(_:)),
                         name: NSNotification.Name.UIKeyboardWillHide,
                         object: nil)
    }
    
    @objc func handleKeyboardAppearance(_ note: Notification) {
        guard
            let userInfo = note.userInfo,
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as?
                NSValue),
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as?
                TimeInterval),
            let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as?
                UInt)
            else { return }
        
        let isKeyboardWillShow: Bool = note.name == NSNotification.Name.UIKeyboardWillShow
        let keyboardHeight = isKeyboardWillShow
            ? keyboardFrame.cgRectValue.height
            : 0
        let animationOption = UIViewAnimationOptions.init(rawValue: curve)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: animationOption,
                       animations: {
                            self.textViewBottomConstraint.constant = -keyboardHeight
                            self.view.layoutIfNeeded()
                        },
                       completion: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSubviews(for: true)
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
        textView.isEditable = true
        _ = isEditing
            ? textView.becomeFirstResponder()
            : textView.resignFirstResponder()
        
        barButton.image = isEditing ? #imageLiteral(resourceName: "baseline_save_white_24pt") : #imageLiteral(resourceName: "baseline_edit_white_24pt")
        barButton.target = self
        barButton.action = isEditing
            ? #selector(saveEntry(_:))
            : #selector(editEntry(_:))
    }
}

