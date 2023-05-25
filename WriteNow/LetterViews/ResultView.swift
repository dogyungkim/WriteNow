//
//  ResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/23.
//

import SwiftUI

struct ResultView: View {
    //For Texteditor View State
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
    
    @Binding var str : String {
        didSet{
            text = str
            textCountMgr.text = str
        }
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
                        //Created letter and edit
                        TextEditor(text:$textCountMgr.text)
                            .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                            .padding()
                            .border(.black,width: 2)
                        Spacer()
                        //Character Counter
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
        }
        .navigationTitle("Write Now")
        .toolbar(.hidden, for: .tabBar)
    }
    
    func editGPT() async {
        try? await self.shared.editResponse(str: askText + "부분을" + selectedKeyword + "해줘")
        textCountMgr.text = shared.answer
        self.text = shared.answer
    }
    

}

