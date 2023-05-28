//
//  ProgressingView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/29.
//

import SwiftUI

struct ProgressingView: View {
        @Binding var progress : Double
        var body : some View{
            VStack{
                ProgressView(value: self.progress)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
                Text("자소서 생성 중")
                    .padding(.top , 10)
                    .font(.title3)
            }
        }
}

