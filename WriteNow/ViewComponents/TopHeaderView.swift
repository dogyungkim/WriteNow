//
//  TopHeaderView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/08.
//

import SwiftUI

struct TopHeaderView: View {
    var title = "Write Now"
    init(_ title: String = "") {
        self.title = title
    }
    
    var body: some View {
        ZStack{
            Color("MainColor")
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            Text(title)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(height:40)
    }
    
    struct TopHeaderView_Previews: PreviewProvider {
        static var previews: some View {
            TopHeaderView("Write Now")
        }
    }
}
