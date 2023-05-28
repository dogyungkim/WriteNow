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
    @State private var viewState : Bool = false
    @State private var progress : Double = 1
    
    //For edit Letter
    @State private var askText : String = ""
    
    //For picker
    @State var selectedKeyword = "강조"
    
    @ObservedObject var viewModel : CollegeLetterViewModel
    
    init(viewModel : CollegeLetterViewModel){
        self.viewModel  = viewModel
    }
    
    var body: some View {
        VStack{
            ZStack{
                if !viewState {
                   Progressing(progress: progress)
                } else {
                    VStack{
                        TextEditView(text: viewModel.resultText, counted: viewModel.textCount, noSpaceCounted: viewModel.noSpaceTextCount)
                        Divider()
                            .padding(10)
                        
                        //To edit created Letter
                        KeywordView(selectedKeyword: $selectedKeyword,askText: $askText)
                        MyButton("자소서 수정")
                            .onTapGesture {
                                viewState = false
                                Task{
                                    viewState = try await viewModel.editGPT(editText: "\"" + askText + "\"를 " + selectedKeyword + "해줘!")
                                }
                            }
                    }
                }
            }
        }
        .navigationTitle("Write Now")
        .toolbar(.hidden, for: .tabBar)
        .onAppear{
            Task{
                viewState = try await viewModel.askGPT()
            }
        }
    }
    
    
    struct Progressing : View {
        var progress : Double
        var body : some View{
            VStack{
                ProgressView(value: progress)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                Text("자소서 생성 중")
                    .padding(.top , 10)
                    .font(.title3)
            }
            
        }
    }

    struct TextEditView : View {
        @State var text : String
        var counted : String
        var noSpaceCounted : String
        
        var body: some View{
            TextEditor(text: $text)
                .frame(maxWidth: 380, maxHeight: .greatestFiniteMagnitude)
                .padding()
                .border(.black,width: 2)
            Spacer()
            HStack(){
                Text("공백 포함 = " + counted)
                    .font(.title3)
                    .foregroundColor(.black)
                Divider()
                    .frame(height: 20)
                Text("공백 미포함 = " + noSpaceCounted)
                    .font(.title3)
                    .foregroundColor(.black)
            }
            .padding(.top)
        }
    }
    
    struct KeywordView : View {
        @Binding var selectedKeyword : String
        @Binding var askText : String
        var selectkeywords = ["강조", "삭제"]
        var body: some View {
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
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView(viewModel: CollegeLetterViewModel(questionSet: QuestionSet(title: "", texts: [TextSet("","")])) )
    }
}
