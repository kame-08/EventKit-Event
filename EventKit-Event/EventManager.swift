//
//  EventManager.swift
//  EventKit-Event
//
//  Created by Ryo on 2022/12/15.
//

import Foundation
import EventKit

class EventManager: ObservableObject {
    var store = EKEventStore()
    // イベントへの認証ステータスのメッセージ
    @Published var statusMessage = ""
    
    init() {
        Task {
            do {
                // カレンダーへのアクセスを要求する
                try await store.requestAccess(to: .event)
            } catch {
                print(error.localizedDescription)
            }
            // イベントへの認証ステータス
            let status = EKEventStore.authorizationStatus(for: .event)
            
            switch status {
            case .notDetermined:
                statusMessage = "カレンダーへのアクセスする\n権限が選択されていません。"
            case .restricted:
                statusMessage = "カレンダーへのアクセスする\n権限がありません。"
            case .denied:
                statusMessage = "カレンダーへのアクセスが\n明示的に拒否されています。"
            case .authorized:
                statusMessage = "カレンダーへのアクセスが\n許可されています。"
            @unknown default:
                statusMessage = "@unknown default"
            }
        }
    }
}
