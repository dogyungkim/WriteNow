//
//  CollegeLetterView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/07.
//

import SwiftUI

struct CollegeLetterView: View {
    
    var body: some View {
        TabView{
            QuestionView()
                .tabItem({
                    Image(systemName: "1.square.fill")
                    Text("문항 1")
                        .font(.title3)
                })
            QuestionView()
                .tabItem({
                    Image(systemName: "2.square.fill")
                    Text("문항 2")
                })
            QuestionView()
                .tabItem({
                    Image(systemName: "3.square.fill")
                    Text("자율 문항")
                })
                
        } // Tabview
        .toolbarBackground(.red, for: .tabBar)
        .accentColor(Color(red: 0, green: 21/255, blue: 41/255))
        
    }
        
}

struct CollegeLetterView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
