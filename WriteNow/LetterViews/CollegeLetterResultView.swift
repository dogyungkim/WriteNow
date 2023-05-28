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
    @State private var editText : String = ""
    
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
                    ProgressingView(progress: $progress)
                } else {
                    VStack{
                        TextEditorView(text: viewModel.resultText, counted: viewModel.textCount, noSpaceCounted: viewModel.noSpaceTextCount)
                        Divider()
                            .padding(10)
                        
                        //To edit created Letter
                        KeywordSelectView(selectedKeyword: $selectedKeyword,askText: $editText)
                        MyButton("자소서 수정")
                            .onTapGesture {
                                viewState = false
                                Task{
                                    viewState = try await viewModel.editGPT(editText: "\"" + editText + "\"를 " + selectedKeyword + "해줘!")
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

}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView(viewModel: CollegeLetterViewModel(questionSet: QuestionSet(title: "", texts: [TextSet("","")])) )
    }
}
