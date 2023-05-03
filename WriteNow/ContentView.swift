//
//  ContentView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/02.
//

import SwiftUI
import OpenAISwift


struct ContentView: View {
    @State var prompt : String = ""
    @StateObject private var network = APICaller.shared
    
    var body: some View {
        VStack{
            Text("Write your questions")
                .font(.headline)
            TextField("Enter your name", text: $prompt)
                .padding()
                .background(Color(uiColor:  . secondarySystemBackground))
                .padding()
            Button("ASK"){
                print("Tapped")
                Task{
                    await network.getResponse(prompt)
                }
            }
                .padding()
            
            Text(network.answer)
                .font(.headline)
                .fontWeight(.bold)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
