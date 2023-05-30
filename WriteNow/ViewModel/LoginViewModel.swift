//
//  LoginViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import FirebaseAuth
import Foundation
class LoginViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var errorMessage : String = ""
    init(){
        
    }
    
    func login(){
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in the blank"
            return false
            
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Email 형식이 아닙니다."
            return false
        }
        return true
    }
    
}
