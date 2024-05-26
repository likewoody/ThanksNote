//
//  Update.swift
//  Test
//
//  Created by Woody on 5/26/24.
//

import SwiftUI

struct Detail: View {
    var id: Int
    var category: String
    var nowDate: String
    
    @State var note: DBModel
    
    var body: some View {
        VStack(content: {
            switch category{
            case "0":
                DetailThanksThree(note: note, nowDate: nowDate)
            case "1":
                DetailGoodyBad(note: note, nowDate: nowDate)
//                GoodyBad()
            default:
                DetailWriteOneline(note: note, nowDate: nowDate)
//                WriteOneline()
            } // switch
            
        }) // VStack
        
    } // body
    
} // DetailView

//#Preview {
//    Detail(id: 1, category: "0")
//}
