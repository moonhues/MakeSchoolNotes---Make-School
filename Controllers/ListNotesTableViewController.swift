//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    //var notes = [Note]()
    
    //var notes = [Note]() {
    var notes: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    
    /*override func viewDidLoad() {
     super.viewDidLoad()
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retrieveNotes()
    }
    
    /*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 10
     }*/
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
     /* let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath)
     
     cell.textLabel?.text = "Yay - it's working!" */
     
     let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
     
     cell.noteTitleLabel.text = "note's title"
     cell.noteModificationTimeLabel.text = "note's modification time"
     
     return cell
     }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        // 1
        let row = indexPath.row
        
        // 2
        let note = notes[row]
        
        // 3
        //cell.noteTitleLabel.text = note.title
        
        
        cell.noteTitleLabel.text = note.content
        
        // 4
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        
        return cell
    }
    
    /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // 1
     if let identifier = segue.identifier {
     // 2
     if identifier == "displayNote" {
     // 3
     print("Transitioning to the Display Note View Controller")
     }
     }
     } */
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if let identifier = segue.identifier {
     if identifier == "displayNote" {
     print("Table view cell tapped")
     } else if identifier == "addNote" {
     print("+ button tapped")
     }
     }
     }*/
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                // 4
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    /* // 1
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     // 2
     if editingStyle == .Delete {
     // 3
     notes.removeAtIndex(indexPath.row)
     // 4
     tableView.reloadData()
     }
     }*/
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            //1
            RealmHelper.deleteNote(notes[indexPath.row])
            //2
            notes = RealmHelper.retrieveNotes()
        }
    }
    
}