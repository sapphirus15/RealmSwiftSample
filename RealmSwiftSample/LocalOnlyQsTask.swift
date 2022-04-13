//
//  LocalOnlyQsTask.swift
//  RealmSwiftSample
//
//  Created by Ryan on 2022/04/13.
//

import RealmSwift
import Photos

class LocalOnlyQsTask: Object {
    
    @Persisted var name: String = ""
    @Persisted var owner: String?
    @Persisted var status: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
