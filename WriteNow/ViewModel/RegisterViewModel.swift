//
//  RegisterViewModel.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import Foundation
import FirebaseAuth


class RegisterViewModel : ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    init (){}
    
    func register () {
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self.insertUserRecord(id: userId)
        }
    }
    private func insertUserRecord(id: String){
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        

    }
    
    
    private func validate() -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            
            return false
        }
        
        guard password.count >= 6 else {
            return false
        }
        return true
    }
}
