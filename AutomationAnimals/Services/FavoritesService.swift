//
//  FavoritesService.swift
//  AutomationAnimals
//
//  Created by Matthew Glover on 22/07/2022.
//

import Foundation

extension Notification.Name {
    static var favouritesUpdated = Notification.Name("AutomationAnimals.favouritesUpdated")
}

class FavoritesService {
    
    private var userDefaultsFavoritesKey = "AutomationAnimalsFavoriteUUIDs"
    
    private var allFavoriteIds: [String] {
        let uuids = UserDefaults.standard.array(forKey: userDefaultsFavoritesKey) as? [String] ?? []
        let uuidsSet = Set<String>(uuids)
        return Array(uuidsSet)
    }
    
    func addFavorite(id: UUID) {
        var uuids = allFavoriteIds
        if uuids.contains(id.uuidString) == false {
            uuids.append(id.uuidString)
        }
        UserDefaults.standard.set(uuids, forKey: userDefaultsFavoritesKey)
        NotificationCenter.default.post(name: .favouritesUpdated, object: nil)
    }
    
    func removeFavorite(id: UUID) {
        var uuids = allFavoriteIds
        guard let index = uuids.firstIndex(where: {$0 == id.uuidString}) else {
            return
        }
        
        uuids.remove(at: index)
        UserDefaults.standard.set(uuids, forKey: userDefaultsFavoritesKey)
        NotificationCenter.default.post(name: .favouritesUpdated, object: nil)
    }
    
    func isFavorite(id: UUID) -> Bool {
        return allFavoriteIds.contains(id.uuidString)
    }
}
