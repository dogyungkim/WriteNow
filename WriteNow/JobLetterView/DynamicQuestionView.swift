//
//  DynamicQuestionView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/18.
//

 import SwiftUI
 
struct DynamicQuestionView: View {
    //For progress view
    @State var viewState : Bool = true
    @State var progress : Double = 100
    @State var text : String
    @State var keywordCreated : Bool = false
    
    //For responsetext
    @State var responses : [String] = [] {
        didSet{
            viewState = false
        }
    }
    
    @ObservedObject var viewModel : DynamicLetterViewModel

    //Initializer
    init(headerTitle : String, questions : QuestionSet){
        self.viewModel = DynamicLetterViewModel(headerTitle: headerTitle, questionSet: questions)
        self.text = questions.texts[0].examples
    }
    
    var body: some View {
        NavigationStack{
            //Top header
            TopHeaderView(viewModel.headerTitle)
            VStack{
                VStack{
                    Text(viewModel.questionSet.texts[0].keywords)
                    TextField(viewModel.questionSet.texts[0].examples, text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                .font(.title2)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(30)
                
                Spacer()
                
                ZStack{
                    if !viewState {
                        VStack{
                            ProgressView(value: progress)
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                            Text("키워드 생성 중")
                        }
                    } else {
                        ScrollView{
                            VStack {
                                ForEach(0..<viewModel.questionCount, id: \.self){ index in
                                    QuestionTextView(text: $viewModel.bindText[index], title: viewModel.keywords[index], fieldText: "")
                                }
                            }
                            .padding(20)
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(30)
                        }
                    }
                }
                Spacer()
                
                //자소서 생성 버튼
                if !keywordCreated {
                    Button {
                        Task {
                            viewState = false
                            viewState = try await viewModel.generateKeywords(str:text)
                            keywordCreated = true
                        }
                    } label: {
                        MyButton("키워드 생성")
                    }
                } else {
                    NavigationLink (destination: ResultView(viewModel: viewModel)){
                        MyButton("자소서 생성")
                    }
                }// if Button
            }
            .padding()
        }
    }//body
}
 
struct DynamicQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicQuestionView(headerTitle: "진학 자소서",
                            questions: QuestionSet(
                                title: "",
                                texts: [TextSet("문항을 입력하시면 자소서 작성에 필요한 키워드를 알려드립니다.","삼성전자를 지원한 이유와 입사 후 회사에서 이루고 싶은 꿈을 기술하십시오")]))
    }
}

