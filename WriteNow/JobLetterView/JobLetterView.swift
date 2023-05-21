//
//  JobLetterView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/18.
//

import SwiftUI

struct JobLetterView: View {
    let questionList = [QuestionSet(
        title: "직장에는 무슨 문제가 있으라? 어떤 식으로 자소서를 쓰게 될까? 너무 궁금하네",
        texts: [TextSet("지원 학과","컴퓨터 공학과"),
                TextSet("진로와 관련된 학습 경험 혹은 교내 활동", "IT 창업 동아리 운영진"),
                TextSet("배운 점","협동심, 왜 의미 있다고 생각하는지" )]
    )
   , QuestionSet(
        title: "여기도 무엇을 써야할 까 ? 전혀 모르겠다. 지피티한테 물어보고 야 지피티야 알려조! 해야하나 ?",
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
        }//NavigationStackView
    }//body
}

struct JobLetterView_Previews: PreviewProvider {
    static var previews: some View {
        JobLetterView()
    }
}
