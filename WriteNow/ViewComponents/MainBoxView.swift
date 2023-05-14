//
//  MainBoxView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/12.
//

import SwiftUI

struct MainBoxView: View {
    let title : String
    let icon : String
    var width = 150.0
    var heigt = 150.0
    var color = Color("MainColor")
    var fill = true
    init(title: String, icon: String, width: Double = 150.0, heigt: Double = 150.0, color: Color = Color("MainColor"), fill : Bool = true) {
        self.title = title
        self.icon = icon
        self.width = width
        self.heigt = heigt
        self.color = color
        self.fill = fill
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
            }
        }
        .frame(width: width,height: heigt)
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
