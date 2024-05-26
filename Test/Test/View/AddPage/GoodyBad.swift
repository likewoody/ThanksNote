//
//  GoodyBad.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

import SwiftUI

struct GoodyBad:View{
    @FocusState var isTextFieldFocused: Bool
    @State var goodThing: String = ""
    @State var badThing: String = ""
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
            
            Button("추가하기", action: {
                // DB랑 연결해서 DB에 연결하는 작업하기
                dismiss()
            })
            .frame(width: 80, height: 24)
            .padding()
            .background(.red.opacity(0.7))
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
        }) // VStack
        .navigationTitle("좋은 일 못한 일")
        .navigationBarTitleDisplayMode(.inline)
        
    } // body
} // GoodyBad
