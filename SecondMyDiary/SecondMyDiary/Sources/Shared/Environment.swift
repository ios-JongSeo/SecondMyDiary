//
//  Environment.swift
//  SecondMyDiary
//
//  Created by 김종서 on 2018. 9. 21..
//  Copyright © 2018년 김종서. All rights reserved.
//

import Foundation

class Environment {
    let entryRepository: EntryRepository
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository()) {
        self.entryRepository = entryRepository
    }
}
