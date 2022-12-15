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
        VStack {
            Text(eventManager.statusMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
