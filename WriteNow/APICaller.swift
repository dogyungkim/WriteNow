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
    
    var prompt : String = ""
    
    private init(){
        self.setup()
    }

    @frozen enum Constants{
        static let key = "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"
    }
    
    public func setup(){
        self.openAI = OpenAISwift(authToken: Constants.key)
    }
    
    func makePrompt(topic : String, keywords : [String]){
        prompt = #"자기소개서의 topic은 \(topic)이고 " 키워드 들은"#
        for keyword in keywords{
            prompt.append(keyword)
        }
    }
    
    
    func getResponse() async {
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: #"대학입시를 위한 자기소개서를 쓰려고 해. 내가 "" 사이에 문항을 입력할께. 그리고 자소서에 참고할 키워드들을 입력할께."#),
            ChatMessage(role: .assistant, content: "네. 문항과 키워드를 입력하시면, 자기소개서를 작성하겠습니다."),
            ChatMessage(role: .user, content: self.prompt)
        ]
        do{
            let result = try await openAI?.sendChat(with: chat,maxTokens: 1000)
            answer = result?.choices?.first?.message.content ?? "ERORR 입니다."
            print(result?.choices?.first?.message.content ?? "")
        } catch {
            print("실패 ㅠㅠ")
        }
    }
}



