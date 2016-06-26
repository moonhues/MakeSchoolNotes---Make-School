//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Veronica Tan on 23/6/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

/*class Note {
    var title = ""
    var content = ""
    var modificationTime = NSDate()
} */

class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
}