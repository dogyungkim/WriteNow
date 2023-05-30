//
//  Extensions.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self ) else {
            return [:]
        }
        
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
