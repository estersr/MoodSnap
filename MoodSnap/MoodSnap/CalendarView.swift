//
//  CalendarView.swift
//  MoodSnap
//
//  Created by Esther Ramos on 17/01/26.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var moodStore: MoodStore
    @Environment(\.dismiss) var dismiss
    @Binding var selectedDate: Date
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()
                
                // Moods for selected date
                if let entry = moodStore.entriesForDate(selectedDate).first {
                    VStack(spacing: 15) {
                        Text("Mood on \(selectedDate.formatted(date: .long, time: .omitted))")
                            .font(.headline)
                        
                        HStack(spacing: 20) {
                            Text(entry.emoji)
                                .font(.system(size: 60))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(entry.mood)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text(entry.timestamp.formatted(date: .omitted, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                    }
                    .padding()
                } else {
                    Text("No mood logged for this date")
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
