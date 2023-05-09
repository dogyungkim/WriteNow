//
//  TopHeaderView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/08.
//

import SwiftUI

struct TopHeaderView: View {
    var title = ""
    init(_ title: String = "") {
        self.title = title
    }
    
    var body: some View {
        ZStack{
            Color(red: 0, green: 21/255, blue: 41/255)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            Text("Write Now")
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading,20)
                .foregroundColor(.white)
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity, alignment: .top)
    }
    
    struct TopHeaderView_Previews: PreviewProvider {
        static var previews: some View {
            TopHeaderView()
        }
    }
}
