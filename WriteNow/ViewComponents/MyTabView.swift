//
//  MyTabView.swift
//  WriteNow
//
//  Created by 김도경 on 2023/06/03.
//

import SwiftUI

struct MyTabView: View {
    @Binding var index: Int
    var titles = ["Home", "NewTab1","NewTab2"]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(titles.indices) { id in
                        let title = Text(titles[id]).id(id)
                            .font(.title2)
                            .bold()
                            .onTapGesture {
                                withAnimation() {
                                    index = id
                                }
                            }
                        if self.index == id {
                            title.foregroundColor(.black)
                        } else {
                            title.foregroundColor(.gray)
                        }
                    }
                    .font(.title)
                    .padding(.top, 6)
                    .padding(.horizontal, 5)
                }
                .padding(.leading, 10)

            }.onChange(of: index) { value in
                withAnimation(.easeInOut) {
                    proxy.scrollTo(value, anchor: UnitPoint(x: UnitPoint.leading.x + leftOffset, y: UnitPoint.leading.y))
                }
            }
        }
    }
    private let leftOffset: CGFloat = 0.1
}
