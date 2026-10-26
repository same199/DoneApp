//
//  Activity.swift
//  Done
//
//  Created by LizOk&Same on 11.10.26.
//



import Foundation

struct Activity: Codable {
    let id: UUID
    let title: String
    let description: String
    let createdAt: TimeInterval

    var isCompleted: Bool
    var completedAt: TimeInterval?

    init(
        id: UUID,
        title: String,
        description: String,
        createdAt: TimeInterval,
        isCompleted: Bool = false,
        completedAt: TimeInterval? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.isCompleted = isCompleted
        self.completedAt = completedAt
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case createdAt
        case isCompleted
        case completedAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        createdAt = try container.decode(TimeInterval.self, forKey: .createdAt)

        isCompleted = try container.decodeIfPresent(
            Bool.self,
            forKey: .isCompleted
        ) ?? false

        completedAt = try container.decodeIfPresent(
            TimeInterval.self,
            forKey: .completedAt
        )
    }
}
