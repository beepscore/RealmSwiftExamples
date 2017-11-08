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

        // Date now
        let date = Date()

        let email = "bar@gmail.com"
        let score = 2

        let demoObject = DemoObject(title: title,
                                    date: date,
                                    email: email,
                                    score: score)

        XCTAssertEqual(demoObject.title, title)
        XCTAssertEqual(demoObject.date, date)
        XCTAssertEqual(demoObject.email, email)
        XCTAssertEqual(demoObject.score.value, score)
    }

    func testConvenienceInitEmailNilScoreNil() {

        let title = "foo"

        // Date now
        let date = Date()

        let email: String? = nil
        let score: Int? = nil

        let demoObject = DemoObject(title: title,
                                    date: date,
                                    email: email,
                                    score: score)

        XCTAssertEqual(demoObject.title, title)
        XCTAssertEqual(demoObject.date, date)
        XCTAssertEqual(demoObject.email, email)
        XCTAssertEqual(demoObject.score.value, score)
    }
    
}
