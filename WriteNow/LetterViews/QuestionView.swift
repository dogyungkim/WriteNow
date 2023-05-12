//
//  QuestionView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/10.
//

import SwiftUI

struct QuestionView: View {
    let headerTitle : String
    let questions : QuestionSet
    
    @State var first : String = ""
    @State var second : String = ""
    @State var third : String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                //Header
                TopHeaderView(headerTitle)
                //Body
                VStack{
                    Text(questions.title)
                        .padding(20)
                        .font(.title2)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(30)
                    
                    VStack(alignment: .leading){
                        ForEach (questions.texts, id: \.self) { question in
                            QuestionTextView(
                                text: $first,
                                title:question.keywords,
                                fieldText:question.examples
                            )
                        }
                    }
                    .padding(20)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(30)
                    
                    Spacer()
                    //Create Button with Navigattion
                    NavigationLink(destination: CollegeLetterResultView()){
                        Text("자소서 생성")
                            .frame(width: 300)
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red:22/255,green:119/255,blue:255/255))
                    .padding(.bottom, 30)
                }//Body Vstack
                .padding(10)
            } // Vstack
        }// Navigation View
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(headerTitle: "진학 자소서",questions: QuestionSet(title: "문항 1. 고등학교 재학 기간 중 자신의 진로와 관련하여 어떤 노력을 해왔는지 본인에게 의미 있는 학습 경험과 교내 활동을 중심으로 기술해 주시기 바랍니다.",
                     texts: [TextSet("지원 학과","컴퓨터 공학과"),
                             TextSet("진로와 관련된 학습 경험 혹은 교내 활동", "IT 창업 동아리 운영진"),
                             TextSet("배운 점","협동심, 왜 의미 있다고 생각하는지" )]))
    }
}
