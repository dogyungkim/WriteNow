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
    
    @ObservedObject var viewModel : DynamicLetterViewModel
    
    //For Picker
    var editKeywords = ["강조","삭제","자세히"]
    @State var selectedKeyword = "강조"
    @State var editText : String = ""
    
    init(viewModel : DynamicLetterViewModel) {
        self.viewModel = viewModel
    }
        
    
    var body: some View{
        // If letter is on recieving data
        VStack{
            if !viewProgress {
                VStack{
                    ProgressingView(progress: self.$progress)
                }
            } else {
                VStack{
                    TextEditorView(text: viewModel.resultText, counted: viewModel.textCount, noSpaceCounted: viewModel.noSpaceTextCount)
                    
                    Divider()
                        .padding(10)
                    //To edit created Letter
                    KeywordSelectView(selectedKeyword: $selectedKeyword, askText: $editText)
                    
                    //For editButton
                    MyButton("자소서 수정")
                        .onTapGesture {
                            viewProgress = false
                            Task{
                                viewProgress = try await viewModel.editGPT(editText: "\"" + editText + "\"를 " + selectedKeyword + "해줘!")
                            }
                        }
                        .padding(.bottom, -10)
                    
                }//Vstack
                .padding()
                
            }//IF
        }//VStack
        .onAppear{
            Task {
                viewProgress = try await viewModel.askGPT()
            }
        }
    }//Body
    
}

struct Provider_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(viewModel: DynamicLetterViewModel(headerTitle: "Write Now", questionSet: QuestionSet(title: "", texts: [TextSet("","")])) )
    }
}
 
