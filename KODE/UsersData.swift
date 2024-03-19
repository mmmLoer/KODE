//
//  UsersData.swift
//  KODE
//
//  Created by Матвей Горохов on 20.03.2024.
//

import UIKit

// MARK: - UsersData
struct UsersData: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let avatarURL: String
    let firstName, lastName, userTag, department: String
    let position, birthday, phone: String
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case firstName, lastName, userTag, department, position, birthday, phone
    }
}
enum Department: String, CaseIterable {
    case android, ios, design, management, qa, backOffice = "back_office", frontend, hr, pr, backend, support, analytics, all
}
