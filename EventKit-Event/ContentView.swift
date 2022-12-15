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
    // 変更したいイベント(追加の場合はnil)
    @State var event: EKEvent?
    
    var body: some View {
        if let aEvent = eventManager.events {
            NavigationStack {
                List(aEvent, id: \.self) { event in
                    Button(event.title) {
                        // 変更したいイベントをCreateEventViewに送る
                        self.event = event
                        isShowCreateEventView = true
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
                            // 追加したい場合は、CreateEventViewにイベントを送らない(nilを送る)
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
