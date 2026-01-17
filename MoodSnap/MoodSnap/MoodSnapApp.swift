//
//  MoodSnapApp.swift
//  MoodSnap
//
//  Created by Esther Ramos on 17/01/26.
//

import SwiftUI

@main
struct MoodSnapApp: App {
    @StateObject private var moodStore = MoodStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(moodStore)
        }
    }
}
