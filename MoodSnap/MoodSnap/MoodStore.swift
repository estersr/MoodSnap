//
//  MoodStore.swift
//  MoodSnap
//
//  Created by Esther Ramos on 17/01/26.
//

import Foundation
import Combine

class MoodStore: ObservableObject {
    @Published var entries: [MoodEntry] = []
    private let saveKey = "MoodEntries"
    
    init() {
        loadEntries()
    }
    
    func addEntry(mood: String, emoji: String) {
        let entry = MoodEntry(mood: mood, emoji: emoji)
        entries.insert(entry, at: 0) // Newest first
        saveEntries()
    }
    
    func entriesForDate(_ date: Date) -> [MoodEntry] {
        let calendar = Calendar.current
        return entries.filter { entry in
            calendar.isDate(entry.timestamp, inSameDayAs: date)
        }
    }
    
    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([MoodEntry].self, from: data) {
            entries = decoded
        }
    }
}
