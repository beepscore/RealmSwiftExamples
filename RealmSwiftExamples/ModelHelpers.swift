//
//  ModelHelpers.swift
//  RealmSwiftExamples
//
//  Created by Steve Baker on 11/6/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import Foundation

class ModelHelpers {

    class func randomString() -> String {
        return "Title \(arc4random())"
    }

    class func randomDate() -> NSDate {
        return NSDate(timeIntervalSince1970: TimeInterval(arc4random()))
    }
}
