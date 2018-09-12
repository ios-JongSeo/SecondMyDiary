//
//  SecondMyDiary.swift
//  SecondMyDiary
//
//  Created by 김종서 on 2018. 9. 12..
//  Copyright © 2018년 김종서. All rights reserved.
//

import Foundation

protocol secondMyDiary {
    func add(_ entry: Entry)
    func update(_ entry: Entry)
    func remove(_ entry: Entry)
    func recentEntries(max: Int) -> [Entry]
}
