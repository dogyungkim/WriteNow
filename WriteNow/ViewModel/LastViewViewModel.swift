//
//  LastViewViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/06/03.
//
import OpenAISwift
import Foundation

class LastViewViewModel : ObservableObject {
    //For API
    private var openAI : OpenAISwift = OpenAISwift(authToken: APIKey.key)
    
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
    
    @Published var index : Int = 0
    @Published var topic : String = ""
    
    //For Prompt
    var prompt : String = ""
    
    @Published var firstBinds : [String] = ["","","",""]
    @Published var secondBinds : [String] = ["","","",""]
    @Published var thirdBinds : [String] = ["","","",""]
    @Published var lastBinds : [String] = ["","","",""]
    
    var firstSets : [TextSet] = [
        TextSet("지원학교와 학과", "지원하는 학교와 학과를 작성"),
        TextSet("해당 학과에 관심을 갖게한 개인적 경험 또는 성장 과정", "어떤 경험을 통해 그 분야에 관심을 갖게 되었는지 등을 구체적으로 기술"),
        TextSet("지원 대학의 교육 철학과 가치에 대한 이해", "대학이 강조하는 가치와 자신의 목표, 가치관이 어떻게 일치하는지를 설명"),
        TextSet("지원 대학의 프로그램, 시설, 리소스", "해당 대학이 제공하는 프로그램, 시설, 리소스에 대해 자신의 학문적 또는 개인적 성장에 어떻게 도움을 줄 것인지를 설명" )]
    
    var secondSets : [TextSet] = [
        TextSet( "해당 학과에 대한 관심과 열정", "나의 관심 분야에서 어떤 준비를 했으며, 어떤 목표를 가지고 나아가고 있는지를 설명"),
        TextSet("해당 학과에 진학하기 위한 경험과 학습 활동",  "경험들이 어떻게 나의 성장과 발전에 기여했는지를 설명"),
        TextSet("자기계발", "자신의 자기개발을 위해 어떤 노력을 했는지와 그 결과를 작성"),
        TextSet("학업적인 업적과 성취", "학업적으로 어떤 준비와 노력을 했으며, 어떤 목표를 이루기 위해 노력했는지를 설명" )]
    
    var thirdSets : [TextSet] = [
        TextSet( "진로 목표 및 이유", "자신이 어떤 분야나 직업을 희망하는지 명확하게 기술"),
        TextSet("해당 분야나 직업과 관련된 학습과 경험을 언급",  "경험들이 어떻게 나의 성장과 발전에 기여했는지를 설명"),
        TextSet("전문성과 자기계발", "자신의 전문성을 키우기 위해 어떤 노력을 하고 있는지를 작성"),
        TextSet("장기적인 목표와 계획", "자신의 장기적인 진로 목표와 그를 위한 계획을 작성" )]
    
    var lastSets : [TextSet] = [
        TextSet( "전공 및 관심 분야 선택", "자신이 어떤 전공을 선택하고, 해당 분야에 대한 관심과 열정을 어떻게 가지게 되었는지 설명"),
        TextSet("학업목표와 목표달성 계획",  "대학에서 어떤 학업목표를 가지고 있는지, 어떤 성적을 달성하고 어떤 학업적 성장을 이루고 싶은지를 명확하게 작성"),
        TextSet("학업자원의 활용", "대학에서 제공되는 학업자원을 어떻게 활용할 것인지를 작성"),
        TextSet("학습능력 향상을 위한 계획", "자신의 학습 능력을 향상시키기 위한 계획을 작성")]
    
    
    func makePrompt(){
        print("LM: makingPrompt")
        prompt = "자기소개서 문항은 \"\(self.topic)\"이고, 키워드 들은 "
        
        if index == 0 {
            for i in 0..<4 {
                prompt.append(firstSets[i].keywords + " : " + firstBinds[i] + ", ")
            }
        } else if index == 1 {
            for i in 0..<4 {
                prompt.append(secondSets[i].keywords + " : " + secondBinds[i] + ", ")
            }
        } else if index == 2 {
            for i in 0..<4 {
                prompt.append(thirdSets[i].keywords + " : " + thirdBinds[i] + ", ")
            }
        } else if index == 3 {
            for i in 0..<4 {
                prompt.append(lastSets[i].keywords + " : " + lastBinds[i] + ", ")
            }
        }
        prompt.append("이것들로 자기소개서를 작성해줘! No other explaination is needed")
        print(prompt)
    }
    
    
    func askGPT() async throws -> Bool {
        var success : Bool
        makePrompt()
        print("LM: AskGPT")
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: #"대학입시를 위한 자기소개서를 쓰려고 해. 내가 "" 사이에 문항을 입력할께. 그리고 자소서에 참고할 키워드들을 입력할께."#),
            ChatMessage(role: .assistant, content: "문항과 키워드를 입력하시면, 자기소개서를 작성하겠습니다."),
            ChatMessage(role: .user, content: self.prompt)
        ]
        do{
            let result = try await openAI.sendChat(with: chat)
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
        print("LM: EditGPT")
        let chat: [ChatMessage] = [
            ChatMessage(role: .system, content: "너는 좋은 assistant야"),
            ChatMessage(role: .user, content: "작성해준 \" " + resultText + "\". 이 자소서를 수정 하고 싶어. "),
            ChatMessage(role: .assistant, content: "수정하고 싶은 부분을 알려주세요"),
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
