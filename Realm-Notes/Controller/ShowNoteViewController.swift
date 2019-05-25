//
//  ShowNoteViewController.swift
//  Realm-Notes
//
//  Created by Nadia Ayala on 24/05/19.
//  Copyright © 2019 Nadia Ayala. All rights reserved.
//

import UIKit
import RealmSwift

class ShowNoteViewController: UIViewController {

    let realm = (UIApplication.shared.delegate as! AppDelegate).realm
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
        
    }
    
    
    
    
    @IBOutlet weak var textView: UITextView!
    
    var selectedNote : Note? 
    
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text = selectedNote?.title
        
        navigationItem.rightBarButtonItem = editButtonItem

    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if (editing) {
            // User tapped the Edit button, do what you need
            print("ediitng")
            textView.isEditable = true
            textView.becomeFirstResponder()
        } else {
            // User tapped the Done button, do what you need
            selectedNote?.title = textView.text!
            print("not ediitng")
            textView.isEditable = false
            textView.resignFirstResponder()
            save(noteToSave: selectedNote!)
        }
    }
    
    func save(noteToSave: Note){
        
        do{
            try  realm.write {
                realm.add(noteToSave)
            }
        }
        catch let error {
            print("Error: \(error)")
        }
    }
}

