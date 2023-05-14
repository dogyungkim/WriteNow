//
//  CollegeLetterResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/09.
//

import SwiftUI

struct CollegeLetterResultView: View {
    @State var text : String = ""
    
    let shared = APICaller.shared
    
    let topic : String
    let keywords : [String]
    
    
    init(topic : String ,keywords : [String]){
        UITextView.appearance().backgroundColor  = .clear
        self.topic = topic
        self.keywords = keywords
    }
    
    func getText() {
        
        Task {
            await shared.getResponse()
        }
        
    }
    
    var body: some View {
        VStack{
            //Header
            TextEditor(text:$text)
                .frame(maxWidth: 330, maxHeight: .greatestFiniteMagnitude)
                .padding()
                .cornerRadius(20)
                .task {
                    shared.makePrompt(topic: topic, keywords: keywords)
                    try? await self.shared.getResponse()
                    text = shared.answer
                }
        }
    }
}

struct CollegeLetterResultView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView(topic: "문항1 입니다.!!!", keywords: ["컴퓨터 공학과,IT동아리를 해본적이 있음, 지식을 나누고 더 나은 삶을 사는 것이 진정한 배움의 길"])
    }
}
