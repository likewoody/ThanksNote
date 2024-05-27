//
//  DetailThanksThree.swift
//  Test
//
//  Created by Woody on 5/26/24.
//

import SwiftUI

struct DetailThanksThree: View{

    @FocusState var isTextFieldFocused: Bool
    @State var thanksNote1: String = ""
    @State var thanksNote2: String = ""
    @State var thanksNote3: String = ""
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
            
            Text("감사 노트 1")
                .font(.system(size: 14))
                .padding(.trailing, 145)
            TextField("감사 노트를 적어보세요.", text: $thanksNote1)
                .frame(width: 240, height: 40)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 40)
                .focused($isTextFieldFocused)
                .multilineTextAlignment(.leading)
            
            Text("감사 노트 2")
                .font(.system(size: 14))
                .padding(.trailing, 145)
            TextField("감사 노트를 적어보세요.", text: $thanksNote2)
                .frame(width: 240, height: 40)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 40)
                .focused($isTextFieldFocused)
                .multilineTextAlignment(.leading)
            
            Text("감사 노트 3")
                .font(.system(size: 14))
                .padding(.trailing, 145)
            TextField("감사 노트를 적어보세요.", text: $thanksNote3)
                .frame(width: 240, height: 40)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 60)
                .focused($isTextFieldFocused)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Button("추가하기", action: {
                // DB랑 연결해서 DB에 연결하는 작업하기
                let query = CUDQuery()
                Task{
                    isAlert = try await query.executeQuery(url: URL(string: "http://localhost:8080/iOS/JSP/UpdateThanksNote.jsp?content1=\(thanksNote1)&content2=\(thanksNote2)&content3=\(thanksNote3)&id=\(note.id)")!)
                }
            })
            .frame(width: 80, height: 24)
            .padding()
            .background(.orange.opacity(0.7))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            .alert("수정이 완료 되었습니다.", isPresented: $isAlert) {
                Button("확인", action: {
                    isAlert = false
                    dismiss()
                })
            }
            
            Spacer()
        }) // VStack
        .navigationTitle("감사 노트")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("", systemImage: "trash", action: {
                    isDelete = true
                })
            })
        })
        .onAppear(perform: {
            thanksNote1 = note.content1
            thanksNote2 = note.content2!
            thanksNote3 = note.content3!
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
//        .toolbar(content: {
//            ToolbarItem(placement: .topBarLeading, content: {
//                Image(systemName: "chevron.backward")
//                
////                test()
//                
//            })
//        })
        
    } // body
//    func test(){
//        let query = CUDQuery()
//        query.executeQuery(url: <#T##URL#>)
//    }
    
} // DetailThanksThree
