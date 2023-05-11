//
//  APICaller.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/04.
//

import Foundation
import OpenAISwift

class APICaller: ObservableObject{
    @Published var answer : String = ""
    
    static let shared = APICaller()
    private var openAI : OpenAISwift?
    
    private init(){
        self.setup()
    }

    @frozen enum Constants{
        static let key = "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"
    }
    
    public func setup(){
        self.openAI = OpenAISwift(authToken: Constants.key)
    }
    
    func getResponse(_ prompt : String) async {
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "You are a helpful assistant."),
            ChatMessage(role: .user, content: prompt),
        ]
        do{
            let result = try await openAI?.sendChat(with: chat)
            answer = result?.choices?.first?.message.content ?? "ERORR 입니다."
            print(result?.choices?.first?.message.content ?? "")
        } catch {
            print("실패 ㅠㅠ")
        }
    }
}



