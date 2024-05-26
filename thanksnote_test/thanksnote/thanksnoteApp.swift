//
//  thanksnoteApp.swift
//  thanksnote
//
//  Created by Woody on 5/25/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct thanksnoteApp: App {
    // 만들어 둔 State와 그 State의 상태가 변경되면 print로 변경을 관찰
    static let store = Store(initialState: CalendarViewStore.State()) {
        CalendarViewStore()
            ._printChanges()
    }
    var body: some Scene {
        WindowGroup {
            // this app's store
            CalendarView(store: thanksnoteApp.store)
        }
    }
}
