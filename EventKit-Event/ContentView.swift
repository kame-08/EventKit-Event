//
//  ContentView.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/15.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var eventManager: EventManager
    
    var body: some View {
        if let aEvent = eventManager.events {
            NavigationStack {
                List(aEvent, id: \.self) { event in
                    Text(event.title)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        DatePicker("", selection: $eventManager.day, displayedComponents: .date)
                            .labelsHidden()
                            .onChange(of: eventManager.day) { newValue in
                                eventManager.fetchEvent()
                            }
                    }
                }
            }
        } else {
            Text(eventManager.statusMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
