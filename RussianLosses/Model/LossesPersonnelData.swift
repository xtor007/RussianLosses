//
//  LossesPersonnelData.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import Foundation

struct LossesPersonnelData: Codable, Hashable {
    
    var date: String
    var day: Int
    var personnel: Int
    var pow: Int?
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case personnel
        case pow = "POW"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(String.self, forKey: .date)
        day = try values.decode(Int.self, forKey: .day)
        personnel = try values.decode(Int.self, forKey: .personnel)
        pow = try? values.decode(Int.self, forKey: .pow)
    }
    
}
