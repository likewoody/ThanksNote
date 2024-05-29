//
//  Test.swift
//  Test
//
//  Created by Woody on 5/28/24.
//

import SwiftUI

struct Test: View {
    @State var noteList: [DBModel] = []
    
    var body: some View {
        List{
            ForEach(noteList, id: \.id, content:{ note in
                HStack(content: {
                    Text(((note.content1 ?? note.content2) ?? note.content3) ?? "")
                    
                })
                
            })
        }
        .onAppear {
            noteList.removeAll()
            let query = SearchQuery()
            Task{
                noteList = try await query.loadData(url: URL(string: "http://localhost:8080/iOS/JSP/SearchThanksNote.jsp")!)
            }
        }
        
    }
}

#Preview {
    Test()
}
