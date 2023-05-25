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
    @State var selection : Int? = 0
    
    //For responsetext
    @State var responses : [String] = [] {
        didSet{
            viewState = false
            print(responses)
            for _ in responses.indices{
                bindTexts.append("")
            }
        }
    }
    
    @State var bindTexts : [String] = []
    
    //Header Title
    let headerTitle : String
    
    //For questionText
    var questions : QuestionSet
    
    // For gpt API
    let shared = APICaller.shared
    
    //To send result
    @State var sendText : String = ""
    
    
    //Initializer
    init(headerTitle : String, questions : QuestionSet){
        self.headerTitle = headerTitle
        self.questions = questions
    }
    
    var body: some View {
        
        NavigationStack{
            //Top header
            TopHeaderView("Write Now")
            VStack{
                VStack{
                    Text(questions.texts[0].keywords)
                    TextField(questions.texts[0].examples, text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .font(.title2)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(30)
                .onAppear{
                    self.text = questions.texts.first?.examples ?? ""
                }
                Spacer()
                ZStack{
                    if viewState {
                        VStack{
                            ProgressView(value: progress)
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                            Text("키워드 생성 중")
                        }
                    } else {
                        Spacer()
                        
                        ScrollView{
                            VStack{
                                ForEach(Array(zip(responses.indices, responses)), id: \.0){ index, response in
                                    QuestionTextView(text: $bindTexts[index], title: response, fieldText: "")
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
                    
                    NavigationLink (destination: ResultView(text: sendText), tag:1, selection: $selection){
                        Button {
                            print("자소서 생성 버튼 clicked")
                            for index in bindTexts.indices {
                                sendText += responses[index] + bindTexts[index]
                            }
                            selection = 1
                        } label: {
                            Text("자소서 생성")
                                .frame(width: 300,height: 40)
                                .background(Color("MainColor"))
                                .foregroundColor(.white)
                                .font(.title2)
                                .cornerRadius(30)
                                .padding(.bottom, 3)
                        }
                    }
                }// if Button
            }
            .padding()
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

