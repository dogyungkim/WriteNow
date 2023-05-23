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
    @State var createState : Bool = true
    
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
    
    var body: some View {
        
        NavigationStack{
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
            
            Spacer()
            ZStack{
                if viewState {
                    ProgressView(value: progress)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                } else {
                    Spacer()
                    
                    ScrollView{
                        VStack{
                            ForEach(Array(zip(responses.indices, responses)), id: \.0){ index, response in
                                QuestionTextView(text: $bindText[index], title: response, fieldText: "")
                                    .frame(maxWidth: 410)
                                
                            }
                        }
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(30)
                    }
                    
                }
            }
            Spacer()
            
            //자소서 생성 버튼
            if createState{
                Button {
                    Task {
                        viewState = true
                        print("Button Clicked")
                        try? await self.shared.generateKeywords(str: questions.texts[0].examples)
                        responses = changeResponse()
                        createState = false
                    }
                } label: {
                    MyButton("키워드 생성")
                }
            } else {
                NavigationLink(destination: ResultView(keywords: responses)) {
                    MyButton("자소서 생성")
                }
            }// if Button
        }
    }//body
    
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
                                texts: [TextSet("문항을 입력하시면 자소서 작성에 필요한 키워드를 알려드립니다","본인의 성장과정을 간략히 기술하되 현재의 자신에게 가장 큰 영향을 끼친 사건, 인물 등을 포함하여 기술하시기 바랍니다")]))
    }
}
