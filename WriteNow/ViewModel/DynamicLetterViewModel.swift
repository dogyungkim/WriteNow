//
//  DynamicLetterViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/28.
//

import Foundation
//
//  CollegeLetterViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/26.
//

import Foundation
import OpenAISwift

class DynamicLetterViewModel : ObservableObject {
    
    let headerTitle : String
    var questionSet : QuestionSet
    var mainQuestion : String = ""
    var questionCount : Int = 0
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
    
  
    
    //For Dynamic Keywords
    @Published var keywords : [String] = [] {
        didSet{
            for _ in keywords.indices {
                bindText.append("")
            }
            questionCount = keywords.count
        }
    }
    @Published var bindText : [String] = []
    
    init(headerTitle : String , questionSet : QuestionSet){
        self.headerTitle = headerTitle
        self.questionSet = questionSet
    }
    
    func generateKeywords(str : String) async throws -> Bool {
        print("DVM: KeywordGen ")
        mainQuestion = str
        var success : Bool
        let realCharacterSet: Set<Character> = Set(#"["].'"#)
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: "자기소개서를 작성하려고 하는데 1번 문항이 " + str + " 야. 이 문항에 필요한 중요한 키워드는 뭘까. 배열로 알려줘. 배열 이름은 필요 없어.")]
        
        do{
            let result = try await openAI.sendChat(with: chat,temperature: 0.8)
            var st = result.choices?.first?.message.content ?? "Error입니다."
            //가져온 키워드 수정
            st.removeAll(where: realCharacterSet.contains)
            keywords = st.components(separatedBy: ",")
            success = true
        } catch {
            print("실패 ㅠㅠ")
            success = false
        }
        return success
    }
    
    func makePrompt(){
        print("DVM: makingPrompt")
        prompt = "자기소개서의 topic은 \"\(self.mainQuestion)\"이고 키워드 들은 "
        for i in 0..<questionCount {
            prompt.append(keywords[i] + ":" + bindText[i] + ", ")
        }
        prompt.append("이것들로 자기소개서를 작성해줘!")
        print(prompt)
    }
    
    func askGPT() async throws -> Bool {
        var success : Bool
        makePrompt()
        print("DVM: AskGPT")
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: #"대학입시를 위한 자기소개서를 쓰려고 해. 내가 "" 사이에 문항을 입력할께. 그리고 자소서에 참고할 키워드들을 입력할께."#),
            ChatMessage(role: .assistant, content: "문항과 키워드를 입력하시면, 자기소개서를 작성하겠습니다."),
            ChatMessage(role: .user, content: self.prompt)
        ]
        do{
            let result = try await openAI.sendChat(with: chat, temperature: 0.8)
            resultText = result.choices?.first?.message.content ?? "Error입니다."
            success = true
        } catch{
            resultText = "다시 시도해 주세요"
            success = true
        }
        return success
    }
    
    func editGPT(editText : String) async throws -> Bool {
        var success : Bool
        print("VM: EditGPT: " + editText)
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: "작성해준 \" " + resultText + "\". 이 자소서를 수정 하고 싶어. "),
            ChatMessage(role: .assistant, content: "수정하고 싶은 부분을 알려주시면 다시 작성하겠습니다."),
            ChatMessage(role: .user, content: editText)
        ]
        do{
            let result = try await openAI.sendChat(with: chat)
            resultText = result.choices?.first?.message.content ?? "Error입니다."
            success = true
        } catch {
            resultText = "다시 시도해 주세요"
            success = true
        }
        return success
    }
    
}



