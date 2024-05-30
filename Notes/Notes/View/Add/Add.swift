//
//  Add.swift
//  Notes
//
//  Created by Woody on 5/30/24.
//

import SwiftUI

struct Add: View {
    
    var category: Int
    var nowDate: String
    
    var body: some View {
        VStack(content: {
            switch category{
            case 0:
                AddThanksThree(nowDate: nowDate)
            case 1:
                AddGoodyBad(nowDate: nowDate)
            default:
                AddWriteOneline(nowDate: nowDate)
            }
            
        }) // VStack
    } // body
} // Add

//#Preview {
//    Add(selectedIndex: 2)
//}
