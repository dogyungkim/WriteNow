//
//  CollegeLetterResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/09.
//

import SwiftUI

struct CollegeLetterResultView: View {
    @State var text : String = ""
    
    
    init(){
        UITextView.appearance().backgroundColor  = .clear
    }
    
    var body: some View {
        VStack{
            //Header
            TextEditor(text:$text)
                .frame(maxWidth: 330, maxHeight: .greatestFiniteMagnitude)
                .padding()
                .cornerRadius(20)
            
        }
    }
}

struct CollegeLetterResultView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView()
    }
}
