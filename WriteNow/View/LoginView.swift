//
//  LoginView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/29.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color("MainColor")
                VStack{
                    Text("Write Now")
                        .foregroundColor(.white)
                        .font(.system(size:50))
                        .bold()
                    Text("자소서 작성의 첫 걸음")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }
            .frame(height: 300)
            .ignoresSafeArea()
            .padding(.bottom, -70)
            
            
            
            Form{
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                TextField("이메일", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                
                SecureField("비밀번호", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                
                MyButton("Log In",width: CGFloat(350))
                    .onTapGesture {
                        viewModel.login()
                    }
                
            }
            
            VStack{
                Text("처음 사용하시나요?")
                NavigationLink("Create An Account", destination: Text(""))
                
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
