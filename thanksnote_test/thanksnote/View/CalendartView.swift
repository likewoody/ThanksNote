//
//  ContentView.swift
//  thanksnote
//
//  Created by Woody on 5/25/24.
//

import SwiftUI
import ComposableArchitecture


struct CalendarView: View {
  let store: StoreOf<CalendarViewStore>
  
  var body: some View {
      WithViewStore(self.store, observe: {$0}) { viewStore in
          NavigationView(content: {
              VStack(content: {
                  DatePicker("",
                             selection: viewStore.binding(get: \.selectedDate, send: { date in
                          CalendarViewStore.Action.whichDateSelected(date);
                      }), // closure를 이용하여 선택된 날짜를 action으로 보내준다.
                             displayedComponents: [.date])
                      // 안보이던 label을 hide로 설정함으로써 datepicker가 중앙으로 위치하게 된다.
                      .labelsHidden()
                      // type 변경
                      .datePickerStyle(.automatic)
                      .padding() // DatePicker
                  
              }) // VStack
              .navigationTitle("감사 노트")
              .navigationBarTitleDisplayMode(.inline)
              .toolbar(content: {
                  ToolbarItem(placement: .topBarTrailing, content: {
                      Image(systemName: "plus")
                  })
              })

          }) // NavigationView
          
      } // WithViewStore
      
    } // body
    
} // CalendarView
//#Preview {
//    CounterView(store: SToreOf)
//}
