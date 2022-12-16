//
//  EventView.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/16.
//

import SwiftUI
import EventKit

struct EventView: View {
    @State var event: EKEvent
    @State var viewDate: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title3)
                Text(dateFormatter(date: event.startDate, viewDate: viewDate) + " ~ " + dateFormatter(date: event.endDate, viewDate: viewDate))
                if let url = event.url {
                Text(url.absoluteString)
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(cgColor: event.calendar.cgColor).opacity(0.5))
        .cornerRadius(15)
    }
}

func dateFormatter(date: Date, viewDate: Date) -> String{
    let dateFormatter = DateFormatter()
    
    if Calendar.current.isDate(date, equalTo: viewDate, toGranularity: .day) {
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
    } else {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    return dateFormatter.string(from: Date())
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: EKEvent(), viewDate: Date())
    }
}
