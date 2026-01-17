//
//  ContentView.swift
//  MoodSnap
//
//  Created by Esther Ramos on 17/01/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var moodStore: MoodStore
    @State private var selectedDate = Date()
    @State private var showingCalendar = false
    
    let moods = [
        ("Happy", "😊"),
        ("Neutral", "😐"),
        ("Sad", "😔"),
        ("Excited", "🤩"),
        ("Tired", "😴"),
        ("Stressed", "😫")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Text("How are you feeling?")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text("Tap an emoji to log")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Mood Selection Grid
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(moods, id: \.0) { mood, emoji in
                        moodButton(mood: mood, emoji: emoji)
                    }
                }
                .padding(.horizontal, 30)
                
                // Recent Entries
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Recent Moods")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: { showingCalendar.toggle() }) {
                            Image(systemName: "calendar")
                                .font(.system(size: 18))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    if moodStore.entries.isEmpty {
                        emptyStateView
                    } else {
                        recentMoodsList
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("MoodSnap")
            .sheet(isPresented: $showingCalendar) {
                CalendarView(selectedDate: $selectedDate)
                    .environmentObject(moodStore)
            }
        }
    }
    
    private func moodButton(mood: String, emoji: String) -> some View {
        Button(action: {
            moodStore.addEntry(mood: mood, emoji: emoji)
            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }) {
            VStack(spacing: 12) {
                Text(emoji)
                    .font(.system(size: 50))
                
                Text(mood)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .frame(width: 100, height: 100)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemGray6))
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 15) {
            Image(systemName: "face.smiling")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No moods logged yet")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text("Tap an emoji above to start tracking")
                .font(.caption)
                .foregroundColor(.gray.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
    }
    
    private var recentMoodsList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(moodStore.entries.prefix(5)) { entry in
                    moodRow(entry: entry)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
    }
    
    private func moodRow(entry: MoodEntry) -> some View {
        HStack {
            Text(entry.emoji)
                .font(.system(size: 35))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.mood)
                    .font(.body)
                    .fontWeight(.medium)
                
                Text(entry.dateString)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(entry.dayString)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}
