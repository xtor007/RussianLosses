//
//  LossesData.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import Foundation

struct LossesData {
    
    var date: String
    var day: Int
    var equipment: LossesEquipmentData
    var personnel: LossesPersonnelData
    
    func getDictionary() -> [String:Int] {
        var result = [
            "Personnel":personnel.personnel,
            "Aircraft":equipment.aircraft,
            "Helicopter":equipment.helicopter,
            "Tank":equipment.tank,
            "Armored Personnel Carrier":equipment.apc,
            "Field Artillery":equipment.fieldArtillery,
            "Multiple Rocket Launcher":equipment.mrl,
            "Drone":equipment.drone,
            "Naval Ship":equipment.navalShip,
            "Anti-Aircraft Warfare":equipment.antiAircraftWarfare
        ]
        if let militaryAuto = equipment.militaryAuto {
            result["Military Auto"] = militaryAuto
        }
        if let fuelTank = equipment.fuelTank {
            result["Fuel Tank"] = fuelTank
        }
        if let vehiclesAndFuelTanks = equipment.vehiclesAndFuelTanks {
            result["Vehicles And Fuel Tanks"] = vehiclesAndFuelTanks
        }
        if let specialEquipment = equipment.specialEquipment {
            result["Special Equipment"] = specialEquipment
        }
        if let cruiseMissiles = equipment.cruiseMissiles {
            result["Cruise Missiles"] = cruiseMissiles
        }
        if let pow = personnel.pow {
            result["Prisoner of War"] = pow
        }
        return result
    }
    
}
