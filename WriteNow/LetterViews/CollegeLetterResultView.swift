//
//  CollegeLetterResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/09.
//

import SwiftUI


struct CollegeLetterResultView: View {
    
    //For Texteditor
    @State var text : String = "" {
        didSet{
            viewState = false
        }
    }
    @State private var viewState : Bool = true
    @State private var progress : Double = 1
    
    //For edit Letter
    @State private var askText : String = ""

    //For picker
    @State var selectedKeyword = "keyword"
    var selectkeywords = ["강조", "삭제"]
    
    //For textCount
    @ObservedObject var textCountMgr = TextCountMgr()
    
    let shared = APICaller.shared
    
    let topic : String
    let keywords : [String]
    
    
    init(topic : String ,keywords : [String]){
        self.topic = topic
        self.keywords = keywords
    }
    
    var body: some View {
        VStack{
            ZStack{
                if viewState {
                    VStack{
                        ProgressView(value: progress)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                        Text("자소서 생성 중")
                            .padding(.top , 10)
                            .font(.title3)
                    }
                } else {
                    VStack{
                        TextEditor(text:$textCountMgr.text)
                            .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                            .padding()
                            .border(.black,width: 2)
                        Spacer()
                        HStack(){
                            Text("공백 포함 = " + textCountMgr.counted)
                                .font(.title3)
                                .foregroundColor(.black)
                            Divider()
                                .frame(height: 20)
                            Text("공백 미포함 = " + textCountMgr.noSpaceCount)
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        .padding(.top)
                        
                        Divider()
                            .padding(10)
                        
                        //To edit created Letter
                        HStack{
                            Picker("Select to edit", selection: $selectedKeyword){
                                ForEach(selectkeywords, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(15)
                            
                            TextField("수정 하고 싶은 부분", text: $askText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                        }
                        .padding(.bottom, 5)
                        
                        Button {
                            viewState = true
                            Task{
                                await editGPT()
                            }
                        } label: {
                            Text("자소서 수정")
                                .frame(width: 300,height: 40)
                                .background(Color("MainColor"))
                                .foregroundColor(.white)
                                .font(.title2)
                                .cornerRadius(30)
                        }

                    }
                }
            }
            .task {
                //await askGPT()
                TextCountMgr().text = "테스트"
                self.text = "테스트"
                print("hello")
            }
        }
        .navigationTitle("Write Now")
        .toolbar(.hidden, for: .tabBar)
    }
    
    func askGPT() async {
        print("Asking to GPT")
        shared.makePrompt(topic: topic, keywords: keywords)
        try? await self.shared.getResponse()
        textCountMgr.text = shared.answer
        self.text = shared.answer
    }
    func editGPT() async {
        try? await self.shared.editResponse(str: askText + "부분을" + selectedKeyword + "해줘")
        textCountMgr.text = shared.answer
        self.text = shared.answer
    }
    

}

struct CollegeLetterResultView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView(topic: "문항1 입니다.!!!", keywords: ["컴퓨터 공학과,IT동아리를 해본적이 있음, 지식을 나누고 더 나은 삶을 사는 것이 진정한 배움의 길"])
    }
}
