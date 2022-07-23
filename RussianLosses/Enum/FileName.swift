//
//  FileName.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import Foundation

enum FileName: String {
    
    case equipment = "russia_losses_equipment"
    case personnel = "russia_losses_personnel"
    
    func getFileName()->String {
        return self.rawValue+".json"
    }
    
}
