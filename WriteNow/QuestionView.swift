//
//  QuestionView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/10.
//

import SwiftUI

struct QuestionView: View {
    
    @State var 지원학과 : String = ""
    @State var 교내활동 : String = ""
    @State var 배운점 : String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                //Header
                TopHeaderView("진학 자소서")
                //Body
                Text("문항1. 고등학교 재학 기간 중 자신의 진로와 관련하여 어떤 노력을 해왔는지 본인에게 의미 있는 학습 경험과 교내 활동을 중심으로 기술해 주시기 바랍니다.")
                    .padding(20)
                    .font(.title2)
                VStack(alignment: .leading){
                    Text("지원학과")
                        .font(.title3)
                    TextField("컴퓨터공학과", text: $지원학과)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("진로와 관련된 학습 경험 혹은 교내 활동")
                        .font(.title3)
                    TextField("컴퓨터공학과", text: $교내활동)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("활동들을 통해 배운 점")
                        .font(.title3)
                    TextField("컴퓨터공학과", text: $배운점)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(20)

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
            } // Vstack
            . background(Color(uiColor: .secondarySystemBackground))
        }// Navigation View
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
