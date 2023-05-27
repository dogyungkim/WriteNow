//
//  QuestionView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/10.
//

import SwiftUI



struct QuestionView: View {
    
    var viewModel : CollegeLetterViewModel
    
    @State var bindText : [String]
    
    init(questions : QuestionSet){
        viewModel = CollegeLetterViewModel(questionSet: questions)
        self.bindText = []
        for _ in viewModel.questionSet.texts{
            bindText.append("")
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    MyText(title: viewModel.headerTitle)
                    
                    VStack(alignment: .leading){
                        ForEach(0..<viewModel.questionCount){ index in
                            QuestionTextView(text: $bindText[index], title: viewModel.questionSet.texts[index].keywords, fieldText: viewModel.questionSet.texts[index].examples)
                        }
                    }
                    .padding(20)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(30)
                    
                    Spacer()
                    //Create Button with Navigattion
                    NavigationLink(destination: CollegeLetterResultView(keywords: bindText)){
                       MyButton("자소서생성")
                        
                    }
                }//Body Vstack
                .padding(10)
                .padding(.top, 20)
            } // Vstack
        }// Navigation View
    }
    
    struct MyText : View {
        let title : String
        var body : some View{
            Text(title)
                .font(.title2)
                .padding(15)
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(30)
            
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questions: QuestionSet(title: "문항 1. 고등학교 재학 기간 중 자신의 진로와 관련하여 어떤 노력을 해왔는지 본인에게 의미 있는 학습 경험과 교내 활동을 중심으로 기술해 주시기 바랍니다.",
                     texts: [TextSet("지원 학과","컴퓨터 공학과"),
                             TextSet("진로와 관련된 학습 경험 혹은 교내 활동", "IT 창업 동아리 운영진"),
                             TextSet("배운 점","협동심, 왜 의미 있다고 생각하는지" )]))
    }
}
