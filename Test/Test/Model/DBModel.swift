//
//  ThanksNoteModel.swift
//  Test
//
//  Created by Woody on 5/26/24.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var isNotCurrentMonth: Bool = false
}

struct DBModel: Decodable{
    var id: String
    var category: String
    var content1: String?
    var content2: String?
    var content3: String?
    var date: String
    
    init(id: String, category: String, content1: String? = nil, content2: String? = nil, content3: String? = nil, date: String) {
        self.id = id
        self.category = category
        self.content1 = content1
        self.content2 = content2
        self.content3 = content3
        self.date = date
    }
}

extension DBModel:Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
