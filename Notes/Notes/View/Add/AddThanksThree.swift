//
//  AddThanksThree.swift
//  Notes
//
//  Created by Woody on 5/30/24.
//

import SwiftUI

struct AddThanksThree:View {
    @FocusState var isTextFieldFocused: Bool
    @State var thanksNote1: String = ""
    @State var thanksNote2: String = ""
    @State var thanksNote3: String = ""
    @Environment(\.dismiss) var dismiss
    
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
                .padding(.bottom, 40    )
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
                    try await query.executeQuery(url: URL(string: "http://localhost:8080/insert?content1=\(thanksNote1)&content2=\(thanksNote2)&content3=\(thanksNote3)&category=0")!)
                    dismiss()
                }
            })
            .frame(width: 80, height: 24)
            .padding()
            .background(.orange.opacity(0.7))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
        }) // VStack
        .navigationTitle("감사 노트")
        .navigationBarTitleDisplayMode(.inline)
        
    } // body
} // ThanksNote
