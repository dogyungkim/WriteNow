//
//  Test.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/23.
//

import Foundation

struct reponsesAsList {
    
    var first : String = "['자기소개서', '삼성전자', '지원', '이유', '입사', '회사', '이루고 싶은', '꿈', '기술', '키워드']"
    
    func calu(){
        var second = first.components(separatedBy: ",")
        print(second)
        var result : [String] = []
        let real : Set<Character> = Set("[]'")
        var s : String
        for x in second{
            s = x
            s.removeAll(where: real.contains)
            result.append(x)
        }
        
        print(result)
    }
    /*
    func cutUselessString(strings : [String]) -> [String]{
        var x : String
        var result : [String] = []
        let realCharacterSet: Set<Character> = Set("[]'")
        for string in strings {
            x = string
            x.removeAll(where: realCharacterSet.contains)
            result.append(x)
        }
        
        return result
    }
     */
}
