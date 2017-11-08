//
//  RealmServiceTests.swift
//  RealmSwiftExamplesTests
//
//  Created by Steve Baker on 11/8/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest
@testable import RealmSwiftExamples

class RealmServiceTests: XCTestCase {

    func testShared() {
        XCTAssertNotNil(RealmService.shared)
    }

    func testReadAddUpdateDelete() {

        let realmService = RealmService.shared
        let demoObjects = realmService.realm.objects(DemoObject.self).sorted(byKeyPath: "date")
        let initialCount = demoObjects.count

        let demoObject = DemoObject(title: ModelHelpers.randomString(),
                                    date: ModelHelpers.randomDate(),
                                    email: "foo",
                                    score: 2)
        XCTAssertEqual(demoObject.email, "foo")

        realmService.add(demoObject)
        XCTAssertEqual(demoObjects.count, initialCount + 1)

        realmService.update(demoObject, with: ["email" : "bar"])
        XCTAssertEqual(demoObject.email, "bar")

        realmService.delete(demoObject)
        XCTAssertEqual(demoObjects.count, initialCount)
    }

}
