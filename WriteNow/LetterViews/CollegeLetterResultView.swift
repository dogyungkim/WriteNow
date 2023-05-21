//
//  CollegeLetterResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/09.
//

import SwiftUI

class TextCountMgr: ObservableObject {
    @Published var counted = "0"
    @Published var noSpaceCount = "0"
    @Published var text = "" {
        didSet {
            counted = String(text.count)
            noSpaceCount = String(text.filter{!$0.isWhitespace}.count)
        }
    }
}

struct CollegeLetterResultView: View {
    @State var text : String = "" {
        didSet{
            viewState = false
        }
    }
    @State var viewState : Bool = true
    @State var progress : Double = 1
    
    @ObservedObject var textCountMgr = TextCountMgr()
    
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
            ZStack{
                if viewState {
                    VStack{
                        ProgressView(value: progress)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                        Text("자소서 생성 중")
                            .padding(.top , 10)
                            .font(.title3)
                    }
                } else {
                    VStack{
                        TextEditor(text:$textCountMgr.text)
                            .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                            .padding()
                            .border(.black,width: 2)
                        Spacer()
                        HStack(){
                            Text("공백 포함 = " + textCountMgr.counted)
                                .font(.title3)
                                .foregroundColor(.black)
                            Divider()
                                .frame(height: 20)
                            Text("공백 미포함 = " + textCountMgr.noSpaceCount)
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                    }
                }
            }
            .task {
                print("Asking to GPT")
                shared.makePrompt(topic: topic, keywords: keywords)
                try? await self.shared.getResponse()
                textCountMgr.text = shared.answer
                self.text = shared.answer
            }
        }
        .navigationTitle("Write Now")
        .toolbar(.hidden, for: .tabBar)
    }
}

struct CollegeLetterResultView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView(topic: "문항1 입니다.!!!", keywords: ["컴퓨터 공학과,IT동아리를 해본적이 있음, 지식을 나누고 더 나은 삶을 사는 것이 진정한 배움의 길"])
    }
}
