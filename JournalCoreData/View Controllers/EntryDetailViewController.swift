//
//  EntryDetailViewController.swift
//  JournalCoreData
//
//  Created by Spencer Curtis on 8/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        
        if let title = titleTextField.text,
            let bodyText = bodyTextView.text {
            
            var mood: String!
            
            switch moodSegmentedControl.selectedSegmentIndex {
            case 0:
                mood = Mood.bad.rawValue
            case 1:
                mood = Mood.neutral.rawValue
            case 2:
                mood = Mood.good.rawValue
            default:
                break
            }
            
            if let entry = entry {
                entryController?.update(entry: entry, title: title, bodyText: bodyText, mood: mood, context: CoreDataStack.shared.mainContext)
            } else {
                entryController?.createEntry(with: title, bodyText: bodyText, mood: mood)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded, let entry = entry else { return }
        
        title = entry.title ?? "Create Entry"
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
        
        var segmentIndex = 0
        
        switch entry.mood {
        case Mood.bad.rawValue:
            segmentIndex = 0
        case Mood.neutral.rawValue:
            segmentIndex = 1
        case Mood.good.rawValue:
            segmentIndex = 2
        default:
            break
        }
        
        moodSegmentedControl.selectedSegmentIndex = segmentIndex
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
}
