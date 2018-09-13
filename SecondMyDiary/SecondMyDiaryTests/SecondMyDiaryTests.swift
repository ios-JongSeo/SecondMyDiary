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
    
    func testRemoveEntryFromJournal() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let journal = InMemoryDiary(entries: [oldEntry])
        
        // Run
        journal.remove(oldEntry)
        
        // Verify
        let entry = journal.entry(with: 1)
        XCTAssertEqual(entry, nil)
    }
    
    func test_최근_순으로_엔트리를_불러올_수_있다() {
        // Setup
        let dayBeforeYesterday = Entry(id: 1, createdAt: Date.distantPast, text: "그저께 일기")
        let yesterday = Entry(id: 2, createdAt: Date(), text: "어제 일기")
        let today = Entry(id: 3, createdAt: Date.distantFuture, text: "오늘 일기")
        
        let journal = InMemoryDiary(entries: [dayBeforeYesterday, yesterday, today])
        
        // Run
        let entries = journal.recentEntries(max: 3)
        
        // verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterday, dayBeforeYesterday])
    }
    
    func test_요청한_엔트리의_수만큼_최신_순으로_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry(id: 1, createdAt: Date.distantPast, text: "그저께 일기")
        let yesterDay = Entry(id: 2, createdAt: Date(), text: "어제 일기")
        let today = Entry(id: 3, createdAt: Date.distantFuture, text: "오늘 일기")
        
        let journal = InMemoryDiary(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 1)
        
        // Verify
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries, [today])
    }
    
    func test_존재하는_엔트리보다_많은_수를_요청하면_존재하는_엔트리만큼만_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry(id: 1, createdAt: Date.distantPast, text: "그저께 일기")
        let yesterDay = Entry(id: 2, createdAt: Date(), text: "어제 일기")
        let today = Entry(id: 3, createdAt: Date.distantFuture, text: "오늘 일기")
        
        let journal = InMemoryDiary(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 10)
        
        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
    }
}
