//
//  Day.swift
//  Forecast
//
//  Created by Brody Sears on 2/1/22.
//

import Foundation

// Creating our model object called "Day" using values from the network call
class Day {
//Desired parameters from our API, with their corresponding value types
    let cityName: String
    let date: String
    let icon: String
    let temp: Double
    let description: String
    let hTemp: Double
    let lTemp: Double
  
//Creating a failable(? is what allows it to fail) initializer, which allows us to mitigate failures. If we cannot init a value for some reason, it will return a nil value, rather than crashing the app.
    init?(dayDictionary: [String: Any], cityName: String) {
        
//Parsing the values we need/want. We need to optionally typecast the values as the type we expect.
        guard let temp = dayDictionary["temp"] as? Double,
              let hTemp = dayDictionary["max_temp"] as? Double,
              let lTemp = dayDictionary["low_temp"] as? Double,
              let date = dayDictionary["valid_date"] as? String,
//Parsing down one more level as "weather" contains our "icon" and "description" values
              let weather = dayDictionary["weather"] as? [String: Any],
              let icon = weather["icon"] as? String,
              let description = weather["description"] as? String
//Returning nil as else, to coincide with our failable initializer.
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
