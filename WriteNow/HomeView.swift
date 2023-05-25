//
//  HomeView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/11.
//

import SwiftUI

struct HomeView: View {
    
    @State private var date = Date()
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            //HomeView
            VStack{
                //Header
                TopHeaderView("Write Now")
                //Main page
                DatePicker(
                        "Start Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .padding(10)
                HStack{
                    MainBoxView(title: "취업 자소서", icon:"doc.plaintext")
                        .onTapGesture {
                            selection = 1
                        }
                    MainBoxView(title: "진학 자소서", icon: "graduationcap")
                        .onTapGesture {
                            selection = 2
                        }
                    
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .padding(.bottom, 10)
            .tabItem({
                Image(systemName: "house.fill")
                Text("HomeView")
            }).tag(0)
            /*
            DynamicQuestionView(headerTitle: "취업 자소서",
                                questions: QuestionSet(
                                    title: "",
                                    texts: [TextSet("문항을 입력하시면 자소서 작성에 필요한 키워드를 알려드립니다","본인의 성장과정을 간략히 기술하되 현재의 자신에게 가장 큰 영향을 끼친 사건, 인물 등을 포함하여 기술하시기 바랍니다")]))
            .tabItem({
                Image(systemName: "doc.plaintext")
                Text("취업 자소서")
            }).tag(1)
           CollegeLetterView()
                .tabItem({
                    Image(systemName: "square.and.pencil")
                    Text("진학 자소서")
                }).tag(2)
             */
            
        }//TabView
        .accentColor(Color("MainColor"))
        .animation(.easeOut(duration: 1), value: selection)
    } // body
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
