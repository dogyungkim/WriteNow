//
//  CollegeLetterQuestionSets.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/12.
//

import Foundation

struct QuestionSet {
    let title : String
    let texts : [TextSet]
}

struct TextSet : Hashable {
    let keywords : String
    let examples : String
    init (_ keyword : String, _ example : String){
        self.keywords = keyword
        self.examples = example
    }
}
