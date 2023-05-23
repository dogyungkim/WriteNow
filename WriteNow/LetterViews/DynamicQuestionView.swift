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
    @State var responses : [String] = [] {
        didSet{
            viewState = false
            print(responses)
            for _ in responses.indices{
                bindText.append("")
            }
        }
    }
    
    @State var bindText : [String] = []
  
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
            //Top header
            TopHeaderView("WriteNow")
            VStack{
                Text(questions.texts[0].keywords)
                TextField(questions.texts[0].examples, text: $text)
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
                    Spacer()
                    VStack{
                        ForEach(Array(zip(responses.indices, responses)), id: \.0){ index, response in
                            QuestionTextView(text: $bindText[index], title: response, fieldText: "")
                            
                        }
                    }
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(30)
                }
            }
            
            //자소서 생성 버튼
            Button {
                Task {
                    viewState = true
                    print("Button Clicked")
                    try? await self.shared.generateKeywords(str: questions.texts[0].examples)
                    responses = changeResponse()
                }
            } label: {
                Text("자소서 생성")
                    .frame(width: 300,height: 40)
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(30)
                    .padding(.bottom, 30)
            }
        }
    }
    
    func changeResponse() -> [String]{
        var st = shared.keywords
        let realCharacterSet: Set<Character> = Set(#"["]'"#)
        st.removeAll(where: realCharacterSet.contains)
        return st.components(separatedBy: ",")
    }
}
        

struct DynamicQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicQuestionView(headerTitle: "진학 자소서",
                            questions: QuestionSet(
                                title: "",
                                texts: [TextSet("문항을 입력하시면 자소서 작성에 필요한 키워드를 알려드립니다","지원 직무 관련 프로젝트/과제 중 기술적으로 가장 어려웠던 과제와 해결방안에 대해 구체적으로 서술하여 주시기 바랍니다")]))
    }
}
