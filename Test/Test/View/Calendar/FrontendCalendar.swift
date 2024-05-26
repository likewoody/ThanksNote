//
//  ShowDays.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

import SwiftUI

// MARK: - 일자 셀 뷰
struct CellView: View {
    // 날짜를 calendarGridView로부터 받는다.
    var day: Int
    // 클릭했는지 안했는지 보기 위함
    var clicked: Bool = false
    // forEach를 돌리면서 몇요일인지 가져오기 위함 for 날짜 color
    var index: Int
    
    // 현재 날짜
    let date = Calendar.current.startOfDay(for: Date())
    // 현재 날짜 format용
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    init(day: Int, clicked: Bool, index: Int) {
        self.day = day
        self.clicked = clicked
        self.index = index
    }
    
    var body: some View {
        
        VStack {
            // 날짜 보여주는 뷰
            Text(String(day))
                .frame(minWidth: 40, minHeight: 20)
                .font(.system(size: 18))
                .fixedSize()
                .foregroundStyle(
                    index % 7 == 6 ? .blue : index % 7 == 0 ? .red : .black
                )
                
            // 클릭 시 나타나는 메시지
            if clicked {
                Text("Click")
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .fixedSize(horizontal: false, vertical: true)
            } // if
        
        } // VStack
        .background(
            dateFormatter.string(from: date) == String(day) ? .blue.opacity(0.3) :
                    .clear
        )
        
    } // body
    
} // CellView
