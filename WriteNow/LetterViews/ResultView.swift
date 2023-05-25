//
//  ResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/23.
//

import SwiftUI



struct ResultView: View {
    @State private var progress : Double = 1
    
    @State private var viewProgress : Bool = true
    
    let shared = APICaller.shared
    
    //For textCount
    @ObservedObject var textCountMgr = TextCountMgr()
    
    //For Picker
    var editKeywords = ["강조","삭제","자세히"]
    @State var pickerSelection = "keyword"
    @State var editText : String = ""
    
    init(text : String) {
        editText = text
    }
    
    var body: some View{
        // If letter is on recieving data
        if viewProgress {
            VStack{
                progressState(progress: self.$progress)
            }
            .task {
                await askGPT()
            }
        } else {
            VStack{
                //TextEditor
                TextEditor(text:$textCountMgr.text)
                    .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                    .padding()
                    .border(.black,width: 2)
                Spacer()
                //Counter
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
                    Picker("Edit Keywords",selection: $pickerSelection){
                        ForEach(editKeywords, id: \.self){
                            Text($0)
                        }
                    }
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(15)
                    TextField("수정하고 싶은 문장 혹은 단어", text: $editText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom,15)
                //For editButton
                Button {
                    viewProgress = true
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
            }//Vstack
            .padding()
        }//If
    }//Body

    func askGPT() async {
        try? textCountMgr.text = await shared.generateNormal(str: editText)
        self.viewProgress.toggle()
    }
    
    func editGPT() async {
        try? await self.shared.editResponse(str: editText + "부분을" + pickerSelection + "해줘")
        textCountMgr.text = shared.answer

    }
    
    
    struct progressState: View {
        @Binding var progress : Double
        var body : some View{
            ProgressView(value: self.progress)
                .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
            Text("자소서 생성 중")
                .padding(.top , 10)
                .font(.title3)
        }
    }
}

struct ResultView_Preview: PreviewProvider {
    static var previews: some View {
        ResultView(text: "테스트 결과! 짜잔")
    }
}
