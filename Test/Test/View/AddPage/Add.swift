////
////  Add.swift
////  Test
////
////  Created by Woody on 5/25/24.
////
//
import SwiftUI

struct Add: View {
    
    var selectedIndex: Int
    @State var title: String = ""
    
    var body: some View {
        VStack(content: {
            switch selectedIndex{
            case 0:
                ThanksThree()
            case 1:
                GoodyBad()
            default:
                WriteOneline()
            }
            
        }) // VStack
    } // body
} // Add

//#Preview {
//    Add(selectedIndex: 2)
//}
