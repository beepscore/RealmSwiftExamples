//
//  DemoObject.swift
//  RealmSwiftExamples
//
//  Created by Steve Baker on 11/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation
import RealmSwift

// Object is a Realm class
class DemoObject: Object {

    // objects must be available at runtime, so generally set default value
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()

    // example optional String
    @objc dynamic var email: String? = nil

    // optional Int requires a different syntax
    let score = RealmOptional<Int>()

    // convenience initializer
    convenience init(title: String, date: Date, email: String?, score: Int?) {
        // must call designated initializer
        self.init()

        self.title = title
        self.date = date
        self.email = email
        self.score.value = score
    }

    func scoreString() -> String? {
        guard let scoreValue = score.value else { return nil }
        return String(scoreValue)
    }

}
