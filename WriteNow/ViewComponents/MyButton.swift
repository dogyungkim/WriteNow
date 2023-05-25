//
//  MyButton.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/24.
//

import SwiftUI

struct MyButton: View {
    let title : String
    
    init(_ title : String) {
        self.title = title
    }
    var body: some View {
        Text(title)
            .frame(width: 300,height: 40)
            .background(Color("MainColor"))
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(30)
            .padding(.bottom, 30)
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton("자소서 생성")
    }
}
