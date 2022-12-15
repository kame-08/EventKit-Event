//
//  EventKit_EventApp.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/15.
//

import SwiftUI

@main
struct EventKit_EventApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(EventManager())
        }
    }
}
