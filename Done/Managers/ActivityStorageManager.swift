//
//  ActivityStorageManager.swift
//  Done
//
//  Created by LizOk&Same on 11.10.26.
//


import Foundation

final class ActivityStorage {

    static let shared = ActivityStorage()

    private let storageKey = "savedActivities"

    private init() {}

    func save(_ activity: Activity) {
        var activities = load()
        activities.append(activity)
        saveAll(activities)
    }

    func update(_ activity: Activity) {
        var activities = load()

        guard let index = activities.firstIndex(
            where: { $0.id == activity.id }
        ) else {
            return
        }

        activities[index] = activity
        saveAll(activities)
    }

    func load() -> [Activity] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([Activity].self, from: data)
        } catch {
            print("Ошибка загрузки активностей:", error)
            return []
        }
    }

    private func saveAll(_ activities: [Activity]) {
        do {
            let data = try JSONEncoder().encode(activities)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Ошибка сохранения активностей:", error)
        }
    }
}


