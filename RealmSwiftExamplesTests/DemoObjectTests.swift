//
//  DemoObjectTests.swift
//  RealmSwiftExamplesTests
//
//  Created by Steve Baker on 11/8/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RealmSwiftExamples

class DemoObjectTests: XCTestCase {
    
    func testConvenienceInit() {

        let title = "foo"
        let email = "bar@gmail.com"
        let score = 2

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
        let dateString = "2017-11-07"
        let date = dateFormatter.date(from: dateString)

        let demoObject = DemoObject(title: title,
                                    date: date!,
                                    email: email,
                                    score: score)

        XCTAssertEqual(demoObject.title, title)
        XCTAssertEqual(demoObject.date, date)
        XCTAssertEqual(demoObject.email, email)
        XCTAssertEqual(demoObject.score.value, score)

    }
    
}
