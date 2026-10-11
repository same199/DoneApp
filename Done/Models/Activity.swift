//
//  Activity.swift
//  Done
//
//  Created by LizOk&Same on 11.10.26.
//



import Foundation

struct Activity: Codable {
    var id: UUID
    var title: String
    var description: String
    var createdAt: TimeInterval
    //var isDone: Bool
}
