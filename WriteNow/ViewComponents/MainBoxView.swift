//
//  MainBoxView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/12.
//

import SwiftUI

struct MainBoxView: View {
    let title : String
    let content : String
    let icon : String
    var width = 150.0
    var height = 150.0
    var color = Color("MainColor")
    
    init(title: String, icon: String, width: Double = 150.0, height: Double = 150.0, color: Color = Color("MainColor"),content: String = "") {
        self.title = title
        self.icon = icon
        self.width = width
        self.height = height
        self.color = color
        self.content = content
    }
    var body: some View {
        ZStack{
            VStack{
                Image(systemName: icon)
                    .resizable()
                    .foregroundColor(color)
                    .frame(width: 50,height: 50)
                    .padding(.top,-1)
                Text(title)
                    .padding(.top)
                    .foregroundColor(color)
                    .bold()
                    .font(.title3)
                
                Text(content)
                    .foregroundColor(color)
            }
        }
        .frame(width: width,height: height)
        .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(color, lineWidth: 1)
            )
        .padding(3)
    }
}

struct MainBoxView_Previews: PreviewProvider {
    static var previews: some View {
        MainBoxView(title: "진학 자소서", icon: "1.square.fill")
    }
}
