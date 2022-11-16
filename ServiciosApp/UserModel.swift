//
//  UserModel.swift
//  ServiciosApp
//
//  Created by TEO on 15/11/22.
//

import Foundation

// MARK: - UserModel
struct UserModel: Decodable {
    let user: String
    let age: Int
    let isHappy: Bool
}
