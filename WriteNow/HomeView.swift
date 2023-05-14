//
//  HomeView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/11.
//

import SwiftUI

struct HomeView: View {
    
    @State var selection = 0
    var body: some View {
        TabView(selection: $selection){
            //HomeView
            VStack{
                TopHeaderView("Write Now")
                HStack{
                    MainBoxView(title: "진학 자소서", icon: "graduationcap")
                        .onTapGesture {
                            selection = 1
                        }
                    MainBoxView(title: "취업 자소서", icon:"doc.plaintext" )
                }
                .padding(.top, 30)
                Spacer()
            }
            .tabItem({
                Image(systemName: "house.fill")
                Text("HomeView")
            }).tag(0)
           CollegeLetterView()
                .tabItem({
                    Image(systemName: "square.and.pencil")
                    Text("진학 자소서")
                }).tag(1)
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
