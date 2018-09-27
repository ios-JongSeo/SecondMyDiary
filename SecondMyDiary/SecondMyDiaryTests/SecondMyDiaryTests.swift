//
//  SecondMyDiaryTests.swift
//  SecondMyDiaryTests
//
//  Created by 김종서 on 2018. 9. 12..
//  Copyright © 2018년 김종서. All rights reserved.
//

import XCTest
@testable import SecondMyDiary

extension Entry {
    static var dayBeforeYesterday: Entry { return Entry(id: UUID(),createdAt: Date.distantPast, text: "그저께 일기") }
    static var yesterDay: Entry { return Entry(id: UUID(), createdAt: Date(), text: "어제 일기") }
    static var today: Entry { return Entry(id: UUID(), createdAt: Date.distantFuture, text: "오늘 일기") }
}

class SecondMyDiaryTests: XCTestCase {
    var newEntry: Entry!
    
    func testEditEntryText() {
        // setup
        let entry = Entry(id: UUID(), createdAt: Date(), text: "첫 번째 일기")
        
        // run
        entry.text = "첫 번째 테스트"
        
        // verify
        XCTAssertEqual(entry.text, "첫 번째 테스트")
    }
    
    func testAddEntryToJounal() {
        // setup
        let journal = InMemoryEntryRepository()
        let newEntry = Entry.today

        // run
        journal.add(newEntry)

        // verify
        let entryInJournal: Entry? = journal.entry(with: newEntry.id)
        
        XCTAssertEqual(entryInJournal, .some(newEntry))
//        XCTAssertTrue(entryInJounal === newEntry)
        XCTAssertTrue(entryInJournal?.isIdentical(to: newEntry) == true)
    }
    
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry.yesterDay
        let journal = InMemoryEntryRepository(entries: [oldEntry])
        
        // Run
        let entry = journal.entry(with: oldEntry.id)
        
        // Verify
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
    }
    
    func testUpdateEntry() {
        // Setup
        let oldEntry = Entry.yesterDay
        let journal = InMemoryEntryRepository(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기가 수정 되었습니다."
        journal.update(oldEntry)
        
        // Verify
        let entry = journal.entry(with: oldEntry.id)
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertEqual(entry?.text, .some("일기가 수정 되었습니다."))
    }
    
    func testRemoveEntryFromJournal() {
        // Setup
        let oldEntry = Entry.yesterDay
        let journal = InMemoryEntryRepository(entries: [oldEntry])
        
        // Run
        journal.remove(oldEntry)
        
        // Verify
        let entry = journal.entry(with: oldEntry.id)
        XCTAssertEqual(entry, nil)
    }
    
    func test_최근_순으로_엔트리를_불러올_수_있다() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterday = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryEntryRepository(entries: [dayBeforeYesterday, yesterday, today])
        
        // Run
        let entries = journal.recentEntries(max: 3)
        
        // verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterday, dayBeforeYesterday])
    }
    
    func test_요청한_엔트리의_수만큼_최신_순으로_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryEntryRepository(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 1)
        
        // Verify
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries, [today])
    }
    
    func test_존재하는_엔트리보다_많은_수를_요청하면_존재하는_엔트리만큼만_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryEntryRepository(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 10)
        
        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
    }
}
