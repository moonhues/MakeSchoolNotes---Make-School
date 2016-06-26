//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
    
    var note: Note?
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    /*override func viewWillAppear(animated: Bool) {
     super.viewWillAppear(animated)
     // 1
     noteTitleTextField.text = ""
     noteContentTextView.text = ""
     }*/
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = note {
            // 2
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        } else {
            // 3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /*
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if let identifier = segue.identifier {
     if identifier == "Cancel" {
     print("Cancel button tapped")
     } else if identifier == "Save" {
     print("Save button tapped")
     }
     }
     }*/
    
    /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if let identifier = segue.identifier {
     if identifier == "Cancel" {
     print("Cancel button tapped")
     } else if identifier == "Save" {
     print("Save button tapped")
     
     // 1
     let note = Note()
     // 2
     note.title = noteTitleTextField.text ?? ""
     note.content = noteContentTextView.text
     // 3
     note.modificationTime = NSDate()
     // 1
     let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
     // 2
     listNotesTableViewController.notes.append(note)
     }
     }
     } */
    
    /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
     if segue.identifier == "Save" {
     if let note = note {
     // 1
     note.title = noteTitleTextField.text ?? ""
     note.content = noteContentTextView.text ?? ""
     // 2
     listNotesTableViewController.tableView.reloadData()
     } else {
     // 3
     let newNote = Note()
     newNote.title = noteTitleTextField.text ?? ""
     newNote.content = noteContentTextView.text ?? ""
     newNote.modificationTime = NSDate()
     listNotesTableViewController.notes.append(newNote)
     }
     }
     } */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        if segue.identifier == "Save" {
            // if note exists, update title and content
            if let note = note {
                // 1
                let newNote = Note()
                newNote.title = noteTitleTextField.text ?? ""
                newNote.content = noteContentTextView.text ?? ""
                RealmHelper.updateNote(note, newNote: newNote)
            } else {
                // if note does not exist, create new note
                let note = Note()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = NSDate()
                // 2
                RealmHelper.addNote(note)
            }
            // 3
            listNotesTableViewController.notes = RealmHelper.retrieveNotes()
        }
    }
    
    
}
