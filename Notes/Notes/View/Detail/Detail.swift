//
//  Detail.swift
//  Notes
//
//  Created by Woody on 5/30/24.
//


import SwiftUI

struct Detail: View {
    @State var id: String
    @State var category: String
    @State var nowDate: String
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
