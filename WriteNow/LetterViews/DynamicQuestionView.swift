//
//  DynamicQuestionView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/18.
//

import SwiftUI

struct DynamicQuestionView: View {
    //For progress view
    @State var viewState : Bool = false
    @State var progress : Double = 100
    @State var text : String = ""
    
    //For responsetext
    @State var response : String = "" {
        didSet{
            viewState = false
        }
    }
    //Header Title
    let headerTitle : String
    //For questionText
    var questions : QuestionSet
    // For gpt API
    let shared = APICaller.shared
    
    //Initializer
    init(headerTitle : String, questions : QuestionSet){
        self.headerTitle = headerTitle
        self.questions = questions
    }
    
    var body: some View{
        VStack{
            //
            VStack{
                QuestionTextView(text: $text, title: questions.texts[0].keywords, fieldText: questions.texts[0].examples)
            }
            .frame(width: 370)
            .padding(20)
            .font(.title2)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(30)
            
            ZStack{
                if viewState {
                    ProgressView(value: progress)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                        .frame(height: 634)
                } else {
                    TextEditor(text: $response)
                        .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                        .padding()
                        .border(.black,width: 1)
                }
            }
            
            //자소서 생성 버튼
            Text("자소서 생성")
                .frame(width: 300,height: 40)
                .background(Color("MainColor"))
                .foregroundColor(.white)
                .font(.title2)
                .cornerRadius(30)
                .padding(.bottom, 30)
                .onTapGesture {
                    viewState.toggle()
                }
                .task {
                    try? await self.shared.generateKeywords(str: questions.texts[0].examples)
                    for keyword in shared.answer {
                        response.append(keyword)
                    }
                }
            
            
        }
    }
}
        

struct DynamicQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicQuestionView(headerTitle: "진학 자소서",
                            questions: QuestionSet(
                                title: "",
                                texts: [TextSet("문항을 입력하시면 자소서 작성에 필요한 키워드를 알려드립니다","삼성전자를 지원한 이유와 입사 후 회사에서 이루고 싶은 꿈을 기술하십시오")]))
    }
}
