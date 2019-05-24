//
//  Note.swift
//  notes-realm
//
//  Created by Nadia Ayala on 24/05/19.
//  Copyright © 2019 Nadia Ayala. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var title: String = ""
}
