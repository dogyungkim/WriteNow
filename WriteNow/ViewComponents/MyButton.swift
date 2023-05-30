//
//  MyButton.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/24.
//

import SwiftUI

struct MyButton: View {
    let title : String
    var width : CGFloat
    var height : CGFloat
    
    init(_ title : String, width : CGFloat = CGFloat(300), height : CGFloat = CGFloat(40)){
        self.title = title
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Text(title)
            .frame(width: width, height: height)
            .background(Color("MainColor"))
            .foregroundColor(.white)
            .font(.title2)
            .cornerRadius(30)
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton("자소서 생성")
    }
}
