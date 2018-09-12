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
        let journal = InMemoryDiary()
        let newEntry = Entry(id: 1, createdAt: Date(), text: "일기")

        // run
        journal.add(newEntry)

        // verify
        let entryInJounal: Entry? = journal.entry(with: 1)
        
        XCTAssertEqual(entryInJounal, .some(newEntry))
        XCTAssertTrue(entryInJounal === newEntry)
        XCTAssertTrue(entryInJounal?.isIdentical(to: newEntry) == true)
    }
    
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let journal = InMemoryDiary(entries: [oldEntry])
        
        // Run
        let entry = journal.entry(with: 1)
        
        // Verify
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
    }
    
    func testUpdateEntry() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let journal = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기가 수정 되었습니다."
        journal.update(oldEntry)
        
        // Verify
        let entry = journal.entry(with: 1)
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertEqual(entry?.text, .some("일기가 수정 되었습니다."))
    }
}
