//
//  UserDefaultsManager.swift
//  MovieChallenge
//
//  Created by AnılKaramış on 26.12.2024.
//

import Foundation
 
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private init() {}
    
    func get<T: Codable>(key: String) -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let allItems = try? JSONDecoder().decode([T].self, from: data) else { return [T]() }
        return allItems
    }
    
    func set<T: Codable>(items: [T], key: String) {
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
