//
//  User.swift
//  WriteNow
//
//  Created by 김도경 on 2023/05/30.
//

import Foundation


struct User: Codable {
    let id : String
    let name : String
    let email: String
    let joined: TimeInterval
}
