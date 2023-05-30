//
//  CollegeLetterLastView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import SwiftUI

struct CollegeLetterLastView: View {
    @State var text : String = ""
    
    var body: some View {
        NavigationStack{
            TopHeaderView("진학 자소서")
            VStack{
                Text("자기소개서 문항을 입력해주세요")
                TextField("", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)
            }
            .padding()
            .font(.title2)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(30)
            ScrollView{
                VStack(alignment: .leading){
                    Text("지원동기")
                        .font(.title2)
                        .bold()
                    Divider()
                    VStack(alignment: .leading){
                        Text("어떤 개인적 경험 또는 성장 과정이 해당 학과에 관심을 갖게 되게 했나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("지원하는 학과에 대한 관심과 열정은 어떻게 발전되었나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("지원하는 대학교의 특장점과 명성이 어떻게 선택의 이유가 되었나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                }
                .padding()
                VStack(alignment: .leading){
                    Text("진로계획")
                        .font(.title2)
                        .bold()
                    Divider()
                    VStack(alignment: .leading){
                        Text("대학에서 얻고자 하는 학문적 지식 및 기술적 능력을 적어주세요.")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("자신의 장래희망과, 그것을 이루기 위한 계획을 적어주세요.")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("지원하는 대학교의 특장점과 명성이 어떻게 선택의 이유가 되었나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                }
                .padding()
                VStack(alignment: .leading){
                    Text("지원동기")
                        .font(.title2)
                        .bold()
                    Divider()
                    VStack(alignment: .leading){
                        Text("어떤 개인적 경험 또는 성장 과정이 해당 학과에 관심을 갖게 되게 했나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("지원하는 학과에 대한 관심과 열정은 어떻게 발전되었나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("지원하는 대학교의 특장점과 명성이 어떻게 선택의 이유가 되었나요?")
                        TextField("",text : $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                }
                .padding()
            }
        }
        
    }
}


struct CollegeLetterLastView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterLastView()
    }
}
