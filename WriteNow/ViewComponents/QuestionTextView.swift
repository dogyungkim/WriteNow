//
//  QuestionTextView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/12.
//

import SwiftUI

struct QuestionTextView: View {
    
    @Binding var text : String 
    
    let title : String
    let fieldText : String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .padding(.bottom, 1)
        TextField("ex) " + fieldText, text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom, 10)
            //for Demo Use
            .onAppear{
                text = fieldText
            }
    }
    
}
