//
//  DynamicQuestionView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/18.
//

import SwiftUI

struct DynamicQuestionView: View {
    @State var viewState : Bool = false
    @State var progress : Double = 100
    @State var text : String = ""{
        didSet{
            viewState = false
        }
    }
    
    var body: some View{
        VStack{
            VStack{
                QuestionTextView(text: $text, title: "문항을 입력하시면 자소서 작성에 필요한 키워드를 알려드립니다.", fieldText: "우리 회사에 지원한 이유")
            }
            .frame(width: 370)
            .padding(20)
            .font(.title2)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(30)
            
            
            Button {
                self.text = "setted"
            } label: {
                Text("Hi")
            }

            Spacer()
            VStack{
                if viewState {
                    ProgressView(value: progress)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                        .padding(.bottom, 30)
                        
                }
                Text("자소서 생성")
                    .frame(width: 300,height: 40)
                    .background(Color("MainColor"))
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(30)
                    .padding(.bottom, 30)
                    .onTapGesture {
                        viewState.toggle()
                    }
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red:22/255,green:119/255,blue:255/255))
        }
    }
}
        

struct DynamicQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicQuestionView()
    }
}
