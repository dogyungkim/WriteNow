//
//  CollegeLetterView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/07.
//

import SwiftUI

struct CollegeLetterView: View {
    let questionList = [QuestionSet(
        title: "문항 1. 고등학교 재학 기간 중 자신의 진로와 관련하여 어떤 노력을 해왔는지 본인에게 의미 있는 학습 경험과 교내 활동을 중심으로 기술해 주시기 바랍니다.",
        texts: [TextSet("지원 학과","컴퓨터 공학과"),
                TextSet("진로와 관련된 학습 경험 혹은 교내 활동", "IT 창업 동아리 운영진"),
                TextSet("배운 점","협동심, 왜 의미 있다고 생각하는지" )]
    )
   , QuestionSet(
        title: "문항 2. 고등학교 재학 기간 중 타인과 공동체를 위해 노력한 경험과 이를 통해 배운 점을 기술해 주시기 바랍니다.",
        texts: [TextSet("타인과 공동체를 위해 노력한 경험","매주 토요일 고아원 봉사 등등"),
                TextSet("배운 점", "나의 것을 나누는 것의 행복 등등")]
    )
   ,QuestionSet(
        title: "자율 문항. 필요 시 대학별로 지원동기, 진로 계획 등의 자율 문항 1개를 추가하여 활용하시기 바랍니다.",
        texts: [TextSet("지원 학과","컴퓨터 공학과"),
                TextSet("진로와 관련된 학습 경험 혹은 교내 활동", "IT 창업 동아리 운영진"),
                TextSet("배운 점","협동심, 왜 의미 있다고 생각하는지" )])]

    let headerTitle = "진학 자소서"
    @State var index = 0
    var body: some View {
        NavigationStack{
            VStack{
                TabBarView(index: $index, titles: ["문항 1","문항 2","자율문항"])
                    .padding(10)
                TabView(selection: $index) {
                    ForEach(0..<3){ pageId in
                        QuestionView(headerTitle: questionList[pageId].title, questions: questionList[pageId])
                    }
                }
            }//Vstack
            .background(Color("MainColor"))
            .edgesIgnoringSafeArea(.top)
        }//NavigationView
        /*
        NavigationView{
            VStack{
                TopHeaderView("Write Now")
                VStack{
                    NavigationLink(destination:QuestionView(headerTitle: questionOne.title, questions: questionOne)){
                        MainBoxView(title: "문항 1", icon: "1.square.fill",width: 350)
                    }
                    NavigationLink(destination:QuestionView(headerTitle: questionTwo.title, questions: questionTwo)){
                        MainBoxView(title: "문항 2", icon: "2.square.fill", width: 350)
                    }
                    NavigationLink(destination:QuestionView(headerTitle: questionThree.title, questions: questionThree)){
                        MainBoxView(title: "자율 문항", icon: "3.square.fill",width: 350)
                    }
                }
                Spacer()
            }
        }
         */
    }//body
}

struct CollegeLetterView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterView()
    }
}
