//
//  DemoObject.swift
//  RealmSwiftExamples
//
//  Created by Steve Baker on 11/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation
import RealmSwift

class DemoObject: Object {
    @objc dynamic var title = ""
    @objc dynamic var date = NSDate()
}
