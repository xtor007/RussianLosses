//
//  LossesEquipmentData.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import Foundation

struct LossesEquipmentData: Decodable, Hashable {
    
    var date: String
    var day: Int
    var aircraft: Int
    var helicopter: Int
    var tank: Int
    var apc: Int
    var fieldArtillery: Int
    var mrl: Int
    var drone: Int
    var navalShip: Int
    var antiAircraftWarfare: Int
    let militaryAuto: Int?
    let fuelTank: Int?
    let vehiclesAndFuelTanks: Int?
    let specialEquipment: Int?
    let cruiseMissiles: Int?
    let greatestLossesDirection: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case aircraft
        case helicopter
        case tank
        case drone
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case specialEquipment = "special equipment"
        case cruiseMissiles = "cruise missiles"
        case greatestLossesDirection = "greatest losses direction"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(String.self, forKey: .date)
        if let dayInt = try? values.decode(Int.self, forKey: .day) { //day can be string
            day = dayInt
        } else if let dayString = try? values.decode(String.self, forKey: .day),
                  let dayInt = Int(dayString) {
            day = dayInt
        } else {
            day = 0
        }
        aircraft = try values.decode(Int.self, forKey: .aircraft)
        helicopter = try values.decode(Int.self, forKey: .helicopter)
        tank = try values.decode(Int.self, forKey: .tank)
        drone = try values.decode(Int.self, forKey: .drone)
        apc = try values.decode(Int.self, forKey: .apc)
        fieldArtillery = try values.decode(Int.self, forKey: .fieldArtillery)
        mrl = try values.decode(Int.self, forKey: .mrl)
        navalShip = try values.decode(Int.self, forKey: .navalShip)
        antiAircraftWarfare = try values.decode(Int.self, forKey: .antiAircraftWarfare)
        militaryAuto = try? values.decode(Int.self, forKey: .militaryAuto)
        fuelTank = try? values.decode(Int.self, forKey: .fuelTank)
        vehiclesAndFuelTanks = try? values.decode(Int.self, forKey: .vehiclesAndFuelTanks)
        specialEquipment = try? values.decode(Int.self, forKey: .specialEquipment)
        cruiseMissiles = try? values.decode(Int.self, forKey: .cruiseMissiles)
        greatestLossesDirection = try? values.decode(String.self, forKey: .greatestLossesDirection)
    }
    
    func getAllLossesCount() -> Int {
        var optionalCount = 0
        if let militaryAuto = militaryAuto {
            optionalCount += militaryAuto
        }
        if let fuelTank = fuelTank {
            optionalCount += fuelTank
        }
        if let vehiclesAndFuelTanks = vehiclesAndFuelTanks {
            optionalCount += vehiclesAndFuelTanks
        }
        if let specialEquipment = specialEquipment {
            optionalCount += specialEquipment
        }
        if let cruiseMissiles = cruiseMissiles {
            optionalCount += cruiseMissiles
        }
        return aircraft+helicopter+tank+apc+fieldArtillery+mrl+drone+navalShip+antiAircraftWarfare+optionalCount
    }
    
}
