//
//  BackendCalendar.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

import SwiftUI

struct CalendarView: View {
    
    // dateFormatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    // 요일
    let weekdaySymbols = Calendar.current.veryShortWeekdaySymbols
    
    
    
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    
    @State private var showPicker = false
    @State private var selection = ""
    let notes = ["감사노트", "잘, 못한일", "한 줄 글쓰기"]

    
    // 모델은 아이디, 카테고리, 텍스트, 날짜,
    var body: some View {

        VStack {
            headerView
            calendarGridView
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width < -20 {
                        changeMonth(by: 1)
                    } else if gesture.translation.width > 20 {
                        changeMonth(by: -1)
                    }
                    self.offset = CGSize()
                }
        )
        
        
        GeometryReader(content: { geometry in
            VStack(content: {
                Button(action: {
                    showPicker.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .padding()
                        .foregroundStyle(.white)
                        .background(.orange.opacity(0.6))
                        .clipShape(Circle())
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + 30)
                
                if showPicker {
                    
                    ForEach(0..<notes.count, id: \.self) { index in
                        NavigationLink(destination: Add(selectedIndex: index), label: {
                            Text(notes[index])
                                .frame(width: 110, height: 30) // Text의 크기를 설정
                                .overlay(content: {
                                    RoundedRectangle(cornerRadius: 10)
                                        // stroke 값을 넣어주니까 투명도가 생겨 stroke만 보여진다.
                                        .stroke(.black, lineWidth: 1.0)
                                        .opacity(0.5)
                                }) // overlay
//                                .background(.red)
                                .foregroundStyle(.black)
                            
                        }) // NavigationLink
//                         Vertical로 쌓이던 버튼들을 y축 이동으로 위로 올라오게 한다.
                        .frame(width: 110, height: 30) // NavigationLink의 크기를 설정
                        .position(x: geometry.size.width / 2 - 10, y: (geometry.size.height / 2) - 240)
                    } // ForEach
                    
                } // if
                
            }) // VStack
            .position(x: geometry.size.width - 40, y: geometry.size.height - 100)
        }) // GeometryReader
        
        
    } // CalendarView
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            // header month
            HStack(content: {
                Text(month, formatter: dateFormatter)
                    .font(.title)
                    .padding(.leading, 45)
                    .padding(.bottom, 20)
            }) // HStack
            
            HStack {
                // 요일 표시
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 12))
                }
            } // HStack
            .padding(.bottom, 5)
            Divider()
            
        } // VStack
        
    } // headerView
    
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        return VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                    // 매 달 첫번째 주가 다르기 때문에 시작하는 주에 맞쳐서 구성하기 위해서
                    
                    if index < firstWeekday {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        let date = getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        let clicked = clickedDates.contains(date)
                        
                        
                        CellView(day: day, clicked: clicked, index: index)
                            .padding(.bottom, 40)
                            .onTapGesture {
                                if clicked {
                                    clickedDates.remove(date)
                                } else {
                                    clickedDates.insert(date)
                                }
                            } // CellView
                    } // if else
                } // ForEach
                
            } // LazyGrid
            Divider()
            Spacer()
        } // VStack
    } // calendarGridView
} // CalenderView



// MARK: - 내부 메서드
private extension CalendarView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}
