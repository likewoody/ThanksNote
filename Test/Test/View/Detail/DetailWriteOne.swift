//
//  DetailWriteOne.swift
//  Test
//
//  Created by Woody on 5/26/24.
//

import SwiftUI

struct DetailWriteOneline: View{
    @FocusState var isTextFieldFocused: Bool
    @State var writeOne: String = ""
    @Environment(\.dismiss) var dismiss
    @State var note: DBModel
    @State var isAlert: Bool = false
    @State var isDelete: Bool = false
    
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
                    isAlert = try await query.executeQuery(url: URL(string: "http://localhost:8080/iOS/JSP/UpdateThanksNote.jsp?category1=\(writeOne)&id=\(note.id)")!)
                }
            })
            .frame(width: 80, height: 24)
            .padding()
            .background(.indigo.opacity(0.7))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            .alert("수정이 완료 되었습니다.", isPresented: $isAlert) {
                Button("확인", action: {dismiss()})
            }
            
            Spacer()
        }) // VStack
        .navigationTitle("한 줄 글쓰기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("", systemImage: "trash", action: {
                    isDelete = true
                })
            })
        })
        .onAppear(perform: {
            writeOne = note.content1
        })
        .alert("삭제 하시겠습니까?", isPresented: $isDelete, actions: {
            HStack(content: {
                Button("네", action: {
                    let query = CUDQuery()
                    Task{
                        try await query.executeQuery(url:URL(string: "http://localhost:8080/iOS/JSP/DeleteThanksNote.jsp?id=\(note.id)")!)
                        isDelete = false
                        dismiss()
                    }
                    
                })
                Button("아니요", action: {})
            })
        })
        
    } // body
} // WriteOneLine


