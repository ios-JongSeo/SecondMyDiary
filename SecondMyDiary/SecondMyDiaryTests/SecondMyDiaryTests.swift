//
//  SecondMyDiaryTests.swift
//  SecondMyDiaryTests
//
//  Created by 김종서 on 2018. 9. 12..
//  Copyright © 2018년 김종서. All rights reserved.
//

import XCTest
@testable import SecondMyDiary

class SecondMyDiaryTests: XCTestCase {
    func testEditEntryText() {
        // setup
        let entry = Entry(id: 0, createdAt: Date(), text: "첫 번째 일기")
        
        // run
        entry.text = "첫 번째 테스트"
        
        // verify
        XCTAssertEqual(entry.text, "첫 번째 테스트")
    }
    
    func testAddEntryToJounal() {
        // setup
        let jounal = InMemoryDiary()
        let newEntry = Entry(id: 1, createdAt: Date(), text: "일기")

        // run
        jounal.add(newEntry)

        // verify
        let entryInJounal: Entry? = jounal.entry(with: 1)
        
        XCTAssertEqual(entryInJounal, .some(newEntry))
        XCTAssertTrue(entryInJounal === newEntry)
        XCTAssertTrue(entryInJounal?.isIdentical(to: newEntry) == true)
    }
}
