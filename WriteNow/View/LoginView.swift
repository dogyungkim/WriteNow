//
//  LoginView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/29.
//

import SwiftUI

struct LoginView: View {
    @State var email : String = ""
    var body: some View {
        VStack{
            TopHeaderView("Write Now")
        
            
            
            Form{
                VStack{
                    TextField("이메일", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("이메일", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    MyButton("Log In")
                }
            }
            .padding(.top,200)
            
            VStack{
                Text("처음 사용하시나요?")
                
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
