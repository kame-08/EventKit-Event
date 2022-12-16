//
//  EventView.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/16.
//

import SwiftUI
import EventKit

struct EventView: View {
    @EnvironmentObject var eventManager: EventManager
    @State var event: EKEvent
    //    @Binding var viewDate: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.title3)
                    .fontWeight(.medium)
                if event.isAllDay {
                    // 終日の場合
                    if Calendar.current.isDate(event.startDate, equalTo: event.endDate, toGranularity: .day) {
                        // 日をまたがない
                    } else {
                        Text(allDayFormatter(date: event.startDate, viewDate: eventManager.day) + " ~ " + allDayFormatter(date: event.endDate, viewDate:  eventManager.day))
                    }
                    
                } else {
                    // 終日ではない場合
                    Text(dateFormatter(date: event.startDate, viewDate: eventManager.day) + " ~ " + dateFormatter(date: event.endDate, viewDate: eventManager.day))
                }
                if let url = event.url {
                    Text(url.absoluteString)
                        .font(.caption)
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
    
    return dateFormatter.string(from: date)
}

func allDayFormatter(date: Date, viewDate: Date) -> String{
    let dateFormatter = DateFormatter()
    if Calendar.current.isDate(date, equalTo: viewDate, toGranularity: .day) {
        // 今日の日付(表示日ではないことに注意)
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: date)
    } else {
        // 開始日と終了日が違う場合
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    //    return dateFormatter.string(from: date)
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: EKEvent())
    }
}
