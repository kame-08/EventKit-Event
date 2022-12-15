//
//  ContentView.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/15.
//

import SwiftUI
import EventKit

struct ContentView: View {
    @EnvironmentObject var eventManager: EventManager
    // sheetのフラグ
    @State var isShowCreateEventView = false
    // 変更するイベント(nilの場合は新規追加)
    @State var event: EKEvent?
    
    var body: some View {
        if let aEvent = eventManager.events {
            NavigationStack {
                List(aEvent, id: \.self) { event in
                    Button(event.title) {
                        // 変更の場合は、CreateEventViewに変更したいイベントを送る
                        self.event = event
                        isShowCreateEventView = true
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            eventManager.deleteEvent(event: event)
                        } label: {
                            Label("削除", systemImage: "trash")
                        }
                    }
                }
                .sheet(isPresented: $isShowCreateEventView) {
                    CreateEventView(event: $event)
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
                            // 追加の場合は、CreateEventViewにnilを送る
                            event = nil
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
