//
//  ColorManagerLogic.swift
//  vmkozachenkoPW3
//
//  Created by User on 15.01.2026.
//

import Foundation

protocol ColorManagerLogic {
    var color: ColorModel { get }
    
    func setColor(color: ColorModel)
}
