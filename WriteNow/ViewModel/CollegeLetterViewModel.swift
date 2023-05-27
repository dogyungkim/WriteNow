//
//  CollegeLetterViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/26.
//

import Foundation
import OpenAISwift

class CollegeLetterViewModel : ObservableObject {
    
    let headerTitle = "진학 자소서"
    var questionSet : QuestionSet
    let questionCount : Int
    
    //For API
    private var openAI : OpenAISwift = OpenAISwift(authToken: APIKey.key)

    private var prompt : String = "안녕 GPT"
    
    //For Main Use
    @Published var resultText : String = "" { // Response from gpt
        //For text Count
        didSet{
            self.textCount = String(resultText.count)
            self.noSpaceTextCount = String(resultText.filter{!$0.isWhitespace}.count)
        }
    }
    @Published var textCount = "0"
    @Published var noSpaceTextCount = "0"
    
    init(questionSet : QuestionSet){
        self.questionSet = questionSet
        questionCount = questionSet.texts.count
    }
    
    
    
    
    func makePrompt(keywords : [String]){
        prompt = "자기소개서의 topic은 \"\(self.questionSet.title)\"이고 키워드 들은"
        for keyword in keywords{
            prompt.append(keyword)
        }
    }
    
    func askGPT() async throws -> Bool {
        var success : Bool
        makePrompt(keywords: ["",""])
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: #"대학입시를 위한 자기소개서를 쓰려고 해. 내가 "" 사이에 문항을 입력할께. 그리고 자소서에 참고할 키워드들을 입력할께."#),
            ChatMessage(role: .assistant, content: "네. 문항과 키워드를 입력하시면, 자기소개서를 작성하겠습니다."),
            ChatMessage(role: .user, content: self.prompt)
        ]
        do{
            let result = try await openAI.sendChat(with: chat)
            resultText = result.choices?.first?.message.content ?? "Error입니다."
            success = true
        } catch{
            resultText = "다시 시도해 주세요"
            success = false
        }
        return success
    }
    
    func editGPT(editText : String) async throws -> Bool {
        var success : Bool
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: "작성해준 " + resultText + ". 이 자소서를 수정 하고 싶어"),
            ChatMessage(role: .assistant, content: "네. 어떤 부분을 수정하고 싶으신가요? 알려주시면 수정해서 다시 작성해드리도록 하겠습니다."),
            ChatMessage(role: .user, content: editText)
        ]
        do{
            let result = try await openAI.sendChat(with: chat)
            resultText = result.choices?.first?.message.content ?? "Error입니다."
            success = true
        } catch{
            resultText = "다시 시도해 주세요"
            success = false
        }
        return success
    }
    
}



