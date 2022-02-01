//
//  Day.swift
//  Forecast
//
//  Created by Brody Sears on 2/1/22.
//

import Foundation

class Day {
    let cityName: String
    let date: String
    let icon: String
    let temp: Double
    let description: String
    let hTemp: Double
    let lTemp: Double
    
    init?(dayDictionary: [String: Any], cityName: String) {
        guard let temp = dayDictionary["temp"] as? Double,
              let hTemp = dayDictionary["max_temp"] as? Double,
              let lTemp = dayDictionary["low_temp"] as? Double,
              let weather = dayDictionary["weather"] as? [String: Any],
              let icon = weather["icon"] as? String,
              let date = dayDictionary["valid_date"] as? String,
              let description = weather["description"] as? String
        else { return nil }
        
        self.cityName = cityName
        self.date = date
        self.icon = icon
        self.temp = temp
        self.hTemp = hTemp
        self.lTemp = lTemp
        self.description = description
    }
}
