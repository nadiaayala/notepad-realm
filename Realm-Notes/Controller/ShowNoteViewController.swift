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

    @IBOutlet weak var textView: UITextView!
    
    var selectedNote : Note? 
    
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text = selectedNote?.title

    }
}

