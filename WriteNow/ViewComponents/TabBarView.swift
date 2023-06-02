//
//  TabBarView.swift
//  Timetable
//
//  Created by Archie Liu on 2021-05-15.
//

import SwiftUI

struct TabBarView: View {
    @Binding var index: Int 
    var titles = ["Home", "NewTab1","NewTab2"]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(titles.indices) { id in
                        let title = Text(titles[id]).id(id)
                            .onTapGesture {
                                withAnimation() {
                                    index = id
                                }
                            }
                        if self.index == id {
                            title.foregroundColor(.white)
                        } else {
                            title.foregroundColor(.gray)
                        }
                    }
                    .font(.title)
                    .padding(.top, 6)
                    .padding(.horizontal, 5)
                }
                .padding(.leading, 20)
                .padding(.bottom, 20)
            }.onChange(of: index) { value in
                withAnimation(.easeInOut) {
                    proxy.scrollTo(value, anchor: UnitPoint(x: UnitPoint.leading.x + leftOffset, y: UnitPoint.leading.y))
                }
            }
        }
    }
    private let leftOffset: CGFloat = 0.1
}
