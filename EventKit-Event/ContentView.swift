//
//  ContentView.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/15.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var eventManager: EventManager
    // sheetのフラグ
    @State var isShowCreateEventView = false
    
    var body: some View {
        if let aEvent = eventManager.events {
            NavigationStack {
                List(aEvent, id: \.self) { event in
                    Text(event.title)
                }
                .sheet(isPresented: $isShowCreateEventView) {
                    CreateEventView()
                        .presentationDetents([.medium])
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        DatePicker("", selection: $eventManager.day, displayedComponents: .date)
                            .labelsHidden()
                            .onChange(of: eventManager.day) { newValue in
                                eventManager.fetchEvent()
                            }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowCreateEventView = true
                        } label: {
                            Label("追加", systemImage: "plus")
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
