//
//  WishEventCreationModels.swift
//  vmkozachenkoPW3
//
//  Created by User on 19.01.2026.
//

import Foundation

enum WishEventCreationModels {
    
    enum Start {
        struct Response {
            let color: ColorModel
        }
        struct ViewModel {
            let red: CGFloat
            let green: CGFloat
            let blue: CGFloat
            let alpha: CGFloat
        }
    }
    
    enum CreateEvent {
        struct Request {
            let title: String
            let description: String
            let start: Date
            let end: Date
        }
        struct Response {
            
        }
    }
}
