////
////  Add.swift
////  Test
////
////  Created by Woody on 5/25/24.
////
//
import SwiftUI

struct Add: View {
    
    var category: Int
    var nowDate: String
    
    var body: some View {
        VStack(content: {
            switch category{
            case 0:
                ThanksThree(nowDate: nowDate)
            case 1:
                GoodyBad(nowDate: nowDate)
            default:
                WriteOneline(nowDate: nowDate)
            }
            
        }) // VStack
    } // body
} // Add

//#Preview {
//    Add(selectedIndex: 2)
//}
