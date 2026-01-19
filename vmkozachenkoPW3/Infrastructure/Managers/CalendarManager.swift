//
//  CalendarManager.swift
//  vmkozachenkoPW3
//
//  Created by User on 19.01.2026.
//

import Foundation
import EventKit

final class CalendarManager: CalendarManaging {
    
    private let eventStore = EKEventStore()
    
    // Не обрабатываю случаи, когда ивент не создался, только вывожу в лог
    func create(eventModel: CalendarEventModel) {
        eventStore.requestFullAccessToEvents() { [weak self] (granted, error) in
            guard granted, error == nil, let self else {
                return
            }
            let event: EKEvent = EKEvent(
                eventStore: self.eventStore
            )
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.notes = eventModel.description
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            do {
                try self.eventStore.save(event,span: .thisEvent)
            } catch let error as NSError {
                print("failed to save event with error : \(error)")
            }
        }
    }
}
