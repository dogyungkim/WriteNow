//
//  TextEditorView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/29.
//

import SwiftUI

struct TextEditorView: View {
        @State var text : String
        var counted : String
        var noSpaceCounted : String
        
        var body: some View {
            TextEditor(text: $text)
                .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                .padding()
                .border(.black,width: 2)
            Spacer()
            HStack(){
                Text("공백 포함 = " + counted)
                    .font(.title3)
                    .foregroundColor(.black)
                Divider()
                    .frame(height: 20)
                Text("공백 미포함 = " + noSpaceCounted)
                    .font(.title3)
                    .foregroundColor(.black)
            }
            .padding(.top)
        }
}

