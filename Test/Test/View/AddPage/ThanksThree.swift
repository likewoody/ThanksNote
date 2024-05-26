//
//  Thanks3.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

import SwiftUI

struct ThanksThree:View {
    @FocusState var isTextFieldFocused: Bool
    @State var thanksNote1: String = ""
    @State var thanksNote2: String = ""
    @State var thanksNote3: String = ""
    @Environment(\.dismiss) var dismiss
    
    // date formatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 EEE요일"
        return formatter
    }()
    
    
    // for showing Text
    var date = Date()
    
    
    
    var body: some View{
        VStack(content: {
            Spacer()
            // 날짜 보여주기
            Text(date, formatter: dateFormatter)
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
                dismiss()
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
