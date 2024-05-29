//
//  DetailGoodyBad.swift
//  Test
//
//  Created by Woody on 5/26/24.
//

import SwiftUI


struct DetailGoodyBad:View{
    @FocusState var isTextFieldFocused: Bool
    @State var goodThing: String = ""
    @State var badThing: String = ""
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
            
            Text("잘한 일")
                .font(.system(size: 14))
                .padding(.trailing, 145)
            TextField("오늘 잘한 일을 적어보세요.", text: $goodThing)
                .frame(width: 240, height: 40)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 40)
                .focused($isTextFieldFocused)
                .multilineTextAlignment(.leading)
            
            Text("못한 일")
                .font(.system(size: 14))
                .padding(.trailing, 145)
            TextField("오늘 못한 일을 적어보세요.", text: $badThing)
                .frame(width: 240, height: 40)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 40)
                .focused($isTextFieldFocused)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button("수정하기", action: {
                // DB랑 연결해서 DB에 연결하는 작업하기
                let query = CUDQuery()
                Task{
                    isAlert = try await query.executeQuery(url: URL(string: "http://localhost:8080/update?content1=\(goodThing)&content2=\(badThing)&id=\(note.id)")!)
                }
            })
            .frame(width: 80, height: 24)
            .padding()
            .background(.red.opacity(0.7))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            .alert("수정이 완료 되었습니다.", isPresented: $isAlert) {
                Button("확인", action: {dismiss()})
            }
            
            Spacer()
        }) // VStack
        .navigationTitle("좋은 일 못한 일")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("", systemImage: "trash", action: {
                    isDelete = true
                })
            })
        })
        .onAppear(perform: {
            goodThing = note.content1 ?? ""
            badThing = note.content2 ?? ""
        })
        .alert("삭제 하시겠습니까?", isPresented: $isDelete, actions: {
            HStack(content: {
                Button("네", action: {
                    let query = CUDQuery()
                    Task{
                        try await query.executeQuery(url:URL(string: "http://localhost:8080/delete?id=\(note.id)")!)
                        isDelete = false
                        dismiss()
                    }
                    
                })
                Button("아니요", action: {})
            })
        })
        
    } // body
} // GoodyBad
