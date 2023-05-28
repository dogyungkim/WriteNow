//
//  ResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/23.
//

import SwiftUI



struct ResultView: View {
    @State private var progress : Double = 1
    
    @State private var viewProgress : Bool = false
    
    @ObservedObject var viewModel : CollegeLetterViewModel
    
    //For Picker
    var editKeywords = ["강조","삭제","자세히"]
    @State var pickerSelection = "keyword"
    @State var editText : String = ""
    
    init(text : String, viewModel : CollegeLetterViewModel) {
        editText = text
        self.viewModel = viewModel
    }
    
    var body: some View{
        // If letter is on recieving data
        if !viewProgress {
            VStack{
                progressState(progress: self.$progress)
            }
        } else {
            VStack{
                //TextEditor
                TextEditor(text:$viewModel.resultText)
                    .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                    .padding()
                    .border(.black,width: 2)
                Spacer()
                //Counter
                HStack(){
                    Text("공백 포함 = " + viewModel.textCount)
                        .font(.title3)
                        .foregroundColor(.black)
                    Divider()
                        .frame(height: 20)
                    Text("공백 미포함 = " + viewModel.noSpaceTextCount)
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
            .onAppear{
                Task{
                  viewProgress = try await viewModel.askGPT()
                }
            }
        }//If
    
    }//Body
    
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
 
