//
//  RealmServiceTests.swift
//  RealmSwiftExamplesTests
//
//  Created by Steve Baker on 11/8/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import XCTest
// import for type Results<>
import RealmSwift
@testable import RealmSwiftExamples

class RealmServiceTests: XCTestCase {

    func testShared() {
        XCTAssertNotNil(RealmService.shared)
    }

    func testReadAddDelete() {

        let realmService = RealmService.shared
        let demoObjects: Results<DemoObject> = realmService.realm.objects(DemoObject.self).sorted(byKeyPath: "date")
        let initialCount = demoObjects.count

        let demoObject = DemoObject(title: ModelHelpers.randomString(),
                                    date: ModelHelpers.randomDate(),
                                    email: "foo",
                                    score: 2)

        realmService.add(demoObject)
        XCTAssertEqual(demoObjects.count, initialCount + 1)
        realmService.delete(demoObject)
        XCTAssertEqual(demoObjects.count, initialCount)
    }

}
