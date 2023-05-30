//
//  RegisterView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import SwiftUI

struct RegisterView: View {
    @State var email : String = ""
    var body: some View {
        VStack{
            ZStack{
                Color("MainColor")
                VStack{
                    TopHeaderView("Write Now")
                    Text("자소서 작성의 첫 걸음")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding(.top, -15)
                }
            }
            .frame(height: 300)
            .ignoresSafeArea()
            .padding(.bottom, -70)
            
            Form{
                    TextField("이름", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
    
                    TextField("이메일", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
               
                    SecureField("비밀번호", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
          
                    SecureField("비밀번호 확인", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())

                    MyButton("Register", width: CGFloat(350))
            }//Form
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
