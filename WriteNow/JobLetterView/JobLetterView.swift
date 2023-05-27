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
    )]

    let headerTitle = "취업 자소서"
    var body: some View {
        NavigationStack{
            VStack{
                TopHeaderView(headerTitle)
                    .padding(.top, -10)
                TabView() {
                        QuestionView( questions: questionList[0])
                }
            }//Vstack
            .background(Color("MainColor"))
        }//NavigationStackView
    }//body
}

struct JobLetterView_Previews: PreviewProvider {
    static var previews: some View {
        JobLetterView()
    }
}
