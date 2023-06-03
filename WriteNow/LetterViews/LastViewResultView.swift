//
//  LastViewResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/06/03.
//

import SwiftUI

struct LastViewResultView: View {
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
    
    @ObservedObject var viewModel : LastViewViewModel
    
    init(viewModel : LastViewViewModel){
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
