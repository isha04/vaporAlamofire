//
//  task.swift
//  vaporAlamofire
//
//  Created by Isha on 9/13/18.
//  Copyright © 2018 Isha. All rights reserved.
//

struct tasky: Codable {
    var id: String
    var title: String
    var completed: String
    
    init(id: String, title: String, completed: String) {
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id as Any,
            "title" : title as Any,
            "completed" : completed as Any] as [String: Any]
    }
    
}

extension tasky {
    func encode() -> [String: Any] {
        return [
            "id": id as Any,
            "title" : title as Any,
            "completed" : completed as Any] as [String: Any]
    }
}
