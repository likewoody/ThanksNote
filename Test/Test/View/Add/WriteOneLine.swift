//
//  WriteOneLine.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

import SwiftUI

struct WriteOneline: View{
    @FocusState var isTextFieldFocused: Bool
    @State var writeOne: String = ""
    @Environment(\.dismiss) var dismiss
    
    var nowDate: String

    var body: some View{
        VStack(content: {
            
            Spacer()
            // 날짜 보여주기
            Text(nowDate)
                .font(.headline)
            
            Spacer()
            
            Text("한 줄 글쓰기")
                .font(.system(size: 14))
                .padding(.trailing, 145)
            TextField("오늘의 한 줄을 적어보세요.", text: $writeOne)
                .frame(width: 240, height: 40)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 40)
                .focused($isTextFieldFocused)
                .multilineTextAlignment(.leading)
            
            Spacer()
            Button("추가하기", action: {
                // DB랑 연결해서 DB에 연결하는 작업하기
                let query = CUDQuery()
                Task{
                    try await query.executeQuery(url: URL(string: "http://localhost:8080/insert?content1=\(writeOne)&category=2")!)
                    dismiss()
                }
            })
            .frame(width: 80, height: 24)
            .padding()
            .background(.indigo.opacity(0.7))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
        }) // VStack
        .navigationTitle("한 줄 글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        
    } // body
} // WriteOneLine

