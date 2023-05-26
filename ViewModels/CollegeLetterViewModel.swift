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
    let questionSet = QuestionSet(
        title: "문항 1. 고등학교 재학 기간 중 자신의 진로와 관련하여 어떤 노력을 해왔는지 본인에게 의미 있는 학습 경험과 교내 활동을 중심으로 기술해 주시기 바랍니다.",
        texts: [TextSet("지원 학과","컴퓨터 공학과"),
                TextSet("진로와 관련된 학습 경험 혹은 교내 활동", "고등학교 방학 코딩 캠프 참여, 교내 코딩동아리 운영"),
                TextSet("배운 점","서로 다른 사람들과 함께 프로젝트를 진행하며 협동심, 배려심, 협력, 이해심을 배웠습니다." )])
    
    //For API
    private var openAI : OpenAISwift?
    var prompt : String = "안녕 GPT"
    
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
    
    init(){
    }
    
    
    
    
    func makePrompt(keywords : [String]){
        prompt = "자기소개서의 topic은 \"\(self.questionSet.title)\"이고 키워드 들은"
        for keyword in keywords{
            prompt.append(keyword)
        }
    }
    
    func askGPT() async throws -> Bool {
        var
        makePrompt(keywords: ["",""])
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: #"대학입시를 위한 자기소개서를 쓰려고 해. 내가 "" 사이에 문항을 입력할께. 그리고 자소서에 참고할 키워드들을 입력할께."#),
            ChatMessage(role: .assistant, content: "네. 문항과 키워드를 입력하시면, 자기소개서를 작성하겠습니다."),
            ChatMessage(role: .user, content: self.prompt)
        ]
        do{
            return true
        } catch{
            return false
        }
        
        return
    }
    
    
    
}




