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
    func entry(with id: Int) -> Entry?
    func recentEntries(max: Int) -> [Entry]
}

class InMemoryDiary: secondMyDiary {
    private var entries: [Int: Entry]
    
    init(entries: [Entry] = []) {
        var result: [Int: Entry] = [:]
        
        entries.forEach { entry in
            result[entry.id] = entry
        }
        
        self.entries = result
    }
    
    func add(_ entry: Entry) {
        entries[entry.id] = entry
    }
    
    func update(_ entry: Entry) {
        
    }
    
    func remove(_ entry: Entry) {
        entries[entry.id] = nil
    }
    
    func entry(with id: Int) -> Entry? {
        return entries[id]
    }
    
    func recentEntries(max: Int) -> [Entry] {
        let result = entries
            .values
            .sorted { $0.createdAt > $1.createdAt }
            .prefix(max)
        
        return Array(result)
    }
}
