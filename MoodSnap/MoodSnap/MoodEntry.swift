//
//  MoodEntry.swift
//  MoodSnap
//
//  Created by Esther Ramos on 17/01/26.
//

import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let mood: String
    let emoji: String
    let timestamp: Date
    
    init(mood: String, emoji: String, timestamp: Date = Date()) {
        self.id = UUID()
        self.mood = mood
        self.emoji = emoji
        self.timestamp = timestamp
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
    
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: timestamp)
    }
}
