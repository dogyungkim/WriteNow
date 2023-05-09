//
//  ContentView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/02.
//

import SwiftUI
import OpenAISwift


struct ContentView: View {
    var body: some View {
        TabView{
            CollegeLetterView()
                .tabItem({
                    Image(systemName: "1.square.fill")
                    Text("문항 1")
                        .font(.title3)
                })
            CollegeLetterView()
                .tabItem({
                    Image(systemName: "2.square.fill")
                    Text("문항 2")
                })
            CollegeLetterView()
                .tabItem({
                    Image(systemName: "3.square.fill")
                    Text("문항 3")
                })
                
        } // Tabview
        .toolbarBackground(.red, for: .tabBar)
        .accentColor(Color(red: 0, green: 21/255, blue: 41/255))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
