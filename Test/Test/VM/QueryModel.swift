//
//  InsertQuery.swift
//  Test
//
//  Created by Woody on 5/26/24.
//

import SwiftUI

struct SearchQuery{
    func loadData(url: URL) async throws -> [DBModel]{
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([DBModel].self, from: data)
    }
}

//struct SearchQuery{
//    func loadData(url: URL) async throws -> DBModel{
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode(DBModel.self, from: data)
//    }
//}


// Create, Update, Delete
struct CUDQuery{
    func executeQuery(url: URL) async throws -> Bool{
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if data.isEmpty{
            return false
        }else{
            return true
        }
    }
}
