//
//  counter.swift
//  thanksnote
//
//  Created by Woody on 5/25/24.
//
import ComposableArchitecture
import SwiftUI


struct CalendarViewStore: Reducer {
    
    struct CalendarEnvironment { }
    
    
    // 3. 변경된 State를 다시 View로 전달해 화면을 바꾼다.
    @ObservableState
    struct State: Equatable {
        var selectedDate = Date()
    }
  
    // 1. View에서 argument를 전달 받는다.
    enum Action {
        case whichDateSelected(Date)
    }
    
    // 2. Reducer를 통해 전달받은 data를 action 시킨다.
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .whichDateSelected(day):
            state.selectedDate = day
            return .none
        }
    }
}


//struct CalendarViewStore: Reducer{
//    
//    struct CalendarEnvironment { }
//    
//    struct CalendarState:Equatable{ // Equatable을 사용해야 View를 WithViewStore로 관리할 수 있다.
//        var selectedDate: Int = 0
//    }
//    
//    enum CalendarAction{
//        case chooseDate(Int)
//    }
//    
//    func reduce(into state: inout State<Any>, action: Action) -> Effect<Action> {
//        switch action{
//        case let chooseDate(Int):
//            
//        }
//    }
//}
    
//    var body: some ReducerOf<Self>{
//        Reduce { state, action in
//            switch action {
//            case .add:
//                state.count += 1
//                return .none
//            case .sub:
//                state.count -= 1
//                return .none
//            }
//        }
//    }

