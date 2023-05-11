//
//  HomeView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/11.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            TopHeaderView("Write Now")
            Spacer()
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
