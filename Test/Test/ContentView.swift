//
//  ContentView.swift
//  Test
//
//  Created by Woody on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var month = Date()
    
    var body: some View {
        NavigationView{
            VStack {
                CalendarView(month: month)
            }
            .padding()
            
        } // NavigationView
        
    } // body

} // ContentView


// MARK: - Static 프로퍼티
//extension CalenderView {
//    let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMMM yyyy"
//        return formatter
//    }()
//    
//    let weekdaySymbols = Calendar.current.veryShortWeekdaySymbols
//}

#Preview {
    ContentView()
}
