//
//  CollegeLetterLastView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import SwiftUI

struct LastCollegeLetterView: View {
    @State var text : String = ""
    @State var index : Int = 0
    
    @ObservedObject var LastViewModel = LastViewViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("자기소개서 문항을 입력해주세요")
                    .font(.body)
                TextField("", text: $LastViewModel.topic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.body)
            }
            .padding()
            .font(.title2)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(30)
            
            MyTabView(index: $LastViewModel.index, titles: ["지원동기", "준비상황", "진로계획", "학업계획"])
            
            Divider()
            
            TabView(selection: $LastViewModel.index){
                //First
                firstPage(vm: LastViewModel).tag(0)
                secondPage(vm: LastViewModel).tag(1)
                thirdPage(vm: LastViewModel).tag(2)
                lastPage(vm: LastViewModel).tag(3)
                
            }// TabView
            .tabViewStyle(.page(indexDisplayMode: .never))
            NavigationLink(destination: LastViewResultView(viewModel: LastViewModel)){
                MyButton("자소서 생성")
                    .padding(.bottom)
            }
        }// NavigationStack
        
        
    }
    
    struct setText : View {
        @Binding var text : String
        @State var hover : Bool = false
        var title : String
        var hint : String
        var body: some View {
            Text(title)
                .onTapGesture {
                    withAnimation(.easeInOut){
                        hover.toggle()
                    }
                }
            Text(hint)
                .font(.footnote)
                .foregroundColor(.gray)
                .opacity(hover ? 1 : 0)

            TextField("", text : $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
    }
    
    struct firstPage : View {
        @ObservedObject var vm : LastViewViewModel
        var body: some View {
            VStack(alignment: .leading){
                ForEach(0..<4){ index in
                    setText(text: $vm.firstBinds[index], title: vm.firstSets[index].keywords, hint: vm.firstSets[index].examples)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    struct secondPage : View {
        @ObservedObject var vm : LastViewViewModel
        var body: some View {
            VStack(alignment: .leading){
                ForEach(0..<4){ index in
                    setText(text: $vm.secondBinds[index], title: vm.secondSets[index].keywords, hint: vm.secondSets[index].examples)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    struct thirdPage : View {
        @ObservedObject var vm : LastViewViewModel
        var body: some View {
            VStack(alignment: .leading){
                ForEach(0..<4){ index in
                    setText(text: $vm.thirdBinds[index], title: vm.thirdSets[index].keywords, hint: vm.thirdSets[index].examples)
                }
                Spacer()
            }
            .padding()
        }
    }
    
    
    struct lastPage : View {
        @ObservedObject var vm : LastViewViewModel
        var body: some View {
            VStack(alignment: .leading){
                ForEach(0..<4){ index in
                    setText(text: $vm.lastBinds[index], title: vm.lastSets[index].keywords, hint: vm.lastSets[index].examples)
                }
                Spacer()
            }
            .padding()
        }
    }
}


struct CollegeLetterLastView_Previews: PreviewProvider {
    static var previews: some View {
        LastCollegeLetterView()
    }
}
