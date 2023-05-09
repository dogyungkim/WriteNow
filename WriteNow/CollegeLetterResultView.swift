//
//  CollegeLetterResultView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/09.
//

import SwiftUI

struct CollegeLetterResultView: View {
    var text : String = ""
    var prompt : String = ""
    
    var body: some View {
        VStack{
            //Header
            Text("문항 1 자소서")
                .font(.title)
            Text("문항 1 자소서")
                .frame(maxWidth: 330, maxHeight: .infinity)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .cornerRadius(16)
            
            Spacer()
        }
    }
}

struct CollegeLetterResultView_Previews: PreviewProvider {
    static var previews: some View {
        CollegeLetterResultView()
    }
}
