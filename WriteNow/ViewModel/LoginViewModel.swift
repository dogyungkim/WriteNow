//
//  LoginViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import Foundation
class LoginViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    
    init(){
        
    }
    
    func login(){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
    }
    
    
}
