//
//  KeywordSelectView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/29.
//

import SwiftUI

struct KeywordSelectView: View {
        @Binding var selectedKeyword : String
        @Binding var askText : String
    
        var selectkeywords = ["강조", "삭제"]
        var body: some View {
            HStack{
                Picker("Select to edit", selection: $selectedKeyword){
                    ForEach(selectkeywords, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(15)
                
                TextField("수정 하고 싶은 부분", text: $askText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            
        }
}

