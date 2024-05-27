//
//  ContentView.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

/*
     Author: Woody Jo
     Description: 감사, 잘한 일 못한 일, 한 줄 글쓰기 노트
     Start Date : 2024-05-25 토요일
     Version : 1.0.0
 */



// note List View
// 필요한 작업 MySQL을 통해 데이터를 불러와서 List에 보여줘야함.
// 이게 MySQL에서 불러오는 작업이 잘 진행되지 않아 어떻게 진행해야 할지 고민중





import SwiftUI

struct ContentView: View {
    @State var month = Date()
    
    var body: some View {
        NavigationView{
            VStack {
                CalendarView()
            }
            .padding()
            
        } // NavigationView
        
    } // body
    
} // ContentView


struct CalendarView: View {
    
//    var testScheduleList = [
//        DBModel(id: 1, category: "0", content1: "테스트입니다1", content2: "테스트입니다2", content3: "테스트입니다3", date: "2024-05-26"),
//        DBModel(id: 2, category: "1", content1: "테스트입니다1", content2: "테스트입니다2", date: "2024-05-26"),
//        DBModel(id: 3, category: "2", content1: "테스트입니다1", date: "2024-05-26"),
//        DBModel(id: 4, category: "0", content1: "테스트입니다1", content2: "테스트입니다2", content3: "테스트입니다3", date: "2024-05-26"),
//        DBModel(id: 5, category: "1", content1: "테스트입니다1", content2: "테스트입니다2", content3: "테스트입니다3", date: "2024-05-26"),
////        DBModel(id: 0, category: "1", content: "테스트입니다2", date: "2024-05-26"),
////        DBModel(id: 0, category: "2", content: "테스트입니다3", date: "2024-05-26"),
////        DBModel(id: 0, category: "0", content: "테스트입니다4", date: "2024-05-26"),
////        DBModel(id: 0, category: "1", content: "테스트입니다5", date: "2024-05-26"),
////        DBModel(id: 0, category: "2", content: "테스트입니다6", date: "2024-05-26")
//    ]
    
    @State var daysList = [[DateValue]]()
    
    @State private var month: Date = Date()
    @State private var clickedCurrentMonthDates: Date?
    
    // 바깥 최상위 레벨에 위치해 있어야 toggle이 정상적으로 작동한다.
    // beacause of GeometryReader
    @State var showPicker = false
    @State var selection = ""
//    @State var isToday = false
    @State var noteList: [DBModel] = []
//    @State var date: Date = Date()
    
    let nowDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 EEE요일"
        return formatter
    }()
    
    
    // for showing Text
    var nowDate = Date()
    
    init(
        month: Date = Date(),
        clickedCurrentMonthDates: Date? = nil
    ) {
        _month = State(initialValue: month)
        _clickedCurrentMonthDates = State(initialValue: clickedCurrentMonthDates)
    }
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
            noteListView
        }
    } // body
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                yearMonthView
                    .padding()
                
                //                Spacer()
                //                Button(
                //                    action: { },
                //                    label: {
                //                        Image(systemName: "list.bullet")
                //                            .font(.title)
                //                            .foregroundColor(.black)
                //                    }
                //                )
            } // HStack
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            
            HStack {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { symbol in
                    Text(Self.weekdaySymbols[symbol].uppercased())
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            } // HStack
            .padding(.bottom, 5)
        } // VStack
    } // headerView
    
    // MARK: - 연월 표시
    private var yearMonthView: some View {
        HStack(alignment: .center, spacing: 20) {
            Spacer()
            Button(
                action: {
                    changeMonth(by: -1)
                },
                label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(canMoveToPreviousMonth() ? .black : . gray)
                }
            ) // Button
            .disabled(!canMoveToPreviousMonth())
            
            // Ex 2024.05
            Text(month, formatter: Self.calendarHeaderDateFormatter)
                .font(.title.bold())
            
            Button(
                action: {
                    changeMonth(by: 1)
                },
                label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(canMoveToNextMonth() ? .black : .gray)
                }
            ) // Button
            .disabled(!canMoveToNextMonth())
            
            Spacer()
        } // HStack
    } // yearMonthView
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = clickedCurrentMonthDates == date
                        let isToday = date.formattedCalendarDayDate == today.formattedCalendarDayDate
                        
//                        clikedDate(date: date)
                        CellView(day: day, clicked: clicked, isToday: isToday)
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(day: day, isCurrentMonthDay: false)
                    } // if  ~ else if
                    
                    
                } // Group
                // 위에 ForEach에서도 실행이 되고 여기서도 실행이 되어 2번 실행된다. 수정 필요
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = getDate(for: index)
                        clickedCurrentMonthDates = date
                        
//                        let query = SearchQuery()
//                        Task{
//                            noteList = try await query.loadData(url: URL(string: "http://localhost:8080/iOS/JSP/SearchThanksNote.jsp?date=\(date)"))
//                        }
                        
                    }
                } // onTapGesture
                
                
            } // ForEach
            
        } // LazyGrid
        
    } //calendarGridView
    
    // MARK: - noteListView and Floating Action View
    private var noteListView: some View{
    
        let notes = ["감사노트", "잘, 못한일", "한 줄 글쓰기"]
        
        return GeometryReader(content: { geometry in
            VStack(content: {
                
//                Group {
                    List{
                        ForEach(noteList.indices, id: \.self) { i in
                            
                            NavigationLink(destination: Detail(id: noteList[i].id, category: noteList[i].category, nowDate: nowDateFormatter.string(from: nowDate), note: noteList[i]), label: {
                                    HStack(content: {
                                        
                                        Text(noteList[i].content1)
                                        Text(noteList[i].date)
                                        
                                       Spacer()
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 10, height: 10)
                                            .foregroundStyle(
                                                noteList[i].category == "0" ? .orange : noteList[i].category == "1" ? .red : .indigo
                                            )
        //                                    .background(.red)
                                            
                                    }) // HStack
                                    .frame(height: 50)
                                })
                        } // ForEach
                    } // List
                    .frame(height: 300)
//                } // Group
                
                // for floating button
                ZStack(content: {
                    Button(action: {
                        showPicker.toggle()
                        
                    }){
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .padding()
                            .foregroundStyle(.white)
                            .background(.orange)
                            .clipShape(Circle())
                    } // Button
                    .position(x: geometry.size.width - 50, y: geometry.size.height / 2 - 200)
                    
                    if showPicker {
                        ForEach(0..<notes.count, id: \.self) { index in
                            NavigationLink(destination: Add(category: index, nowDate: nowDateFormatter.string(from: nowDate)), label: {
                                Text(notes[index])
    //                                .foregroundStyle(.red)
                                    .frame(width: 110, height: 30) // Text의 크기를 설정
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 7)
                                            // stroke 값을 넣어주니까 투명도가 생겨 stroke만 보여진다.
                                            .stroke(.black, lineWidth: 1.0)
                                            .opacity(0.2)
                                    }) // overlay
                                    .foregroundStyle(.black)
                                
                            }) // NavigationLink
                            // Vertical로 쌓이던 버튼들을 y축 이동으로 위로 올라오게 한다.
                            .background(.bar)
                            .frame(width: 110, height: 30) // NavigationLink의 크기를 설정
                            .position(x: geometry.size.width - 55, y: (geometry.size.height / 2) - CGFloat(index * 40) - 250)
                            
                        } // ForEach
                    } // if
                }) // ZStack
            }) // VStack
        }) // GeometryReader
    } // noteListView
} // CalendarView


// MARK: - 일자 셀 뷰
private struct CellView: View {
    private var day: Int
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    private var textColor: Color {
        if clicked {
            return Color.white
        } else if isCurrentMonthDay {
            return Color.black
        } else {
            return Color.gray
        }
    }
    private var backgroundColor: Color {
        if clicked {
            return Color.black
        } else if isToday {
            return Color.blue.opacity(0.5)
        }else {
            return Color.white
        }
    }
    
//    let dates
    
    fileprivate init(
        day: Int,
        clicked: Bool = false,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true
    ) {
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
    }
    
    fileprivate var body: some View {
        VStack {
            Circle()
                .fill(backgroundColor)
                .overlay(Text(String(day)))
                .foregroundColor(textColor)
            
            Spacer()
            
            if clicked {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.red)
                    .frame(width: 10, height: 10)
            } else {
                Spacer()
                    .frame(height: 10)
            }
        }
        .frame(height: 50)
        
    } // fileprivate
    
} // CellView


private extension CalendarView {
    var today: Date {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return Calendar.current.date(from: components)!
    }
    
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM"
        return formatter
    }()
    
    static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
}


private extension CalendarView {
    /// 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        
        
//        if date.formattedCalendarDayDate == today.formattedCalendarDayDate {
//            let query = SearchQuery()
//            Task {
//                // 비동기 작업 수행
//                let result = try await query.loadData(url: URL(string: "http://localhost:8080/iOS/JSP/SearchThanksNote.jsp?date=\(date.formattedCalendarDayDate)")!)
//                
//                // 작업 완료 후 반환값 처리
//                noteList = result
//                print(noteList)
//            }
//        }
//        Timer(timeInterval: 2, repeats: false) { Timer in
//            print("기다리는 중")
//        }
        return date
        
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
    
    /// 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
    
    /// 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: -1) < targetDate {
            return false
        }
        return true
    }
    
    /// 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        return true
    }
    
    /// 변경하려는 월 반환
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
}




extension Date {
    static let calendarDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    var formattedCalendarDayDate: String {
        return Date.calendarDayDateFormatter.string(from: self)
    }
}


#Preview {
    ContentView()
}
