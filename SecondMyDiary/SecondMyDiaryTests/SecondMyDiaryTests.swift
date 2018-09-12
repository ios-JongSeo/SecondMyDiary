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
    func testExample() {
        // setup
        let entry = Entry(id: 0, createdAt: Date(), text: "첫 번째 일기")
        
        // run
        entry.text = "첫 번째 수정"
        
        // verify
        XCTAssertEqual(entry.text, "첫 번째 수정")
    }
}
