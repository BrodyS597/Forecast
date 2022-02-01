//
//  NetwrokController.swift
//  Forecast
//
//  Created by Brody Sears on 2/1/22.
//

import Foundation

class NetworkController {
    private static let baseURLString = "https://api.weatherbit.io/v2.0/forecast/daily"
    
    static func fetchDays(completion: @escaping ([Day]?) -> Void) {
        // Step 1 - create our base URL:
        guard var baseURL = URL(string: baseURLString) else {
            // if we fail to build our baseURL, we will print the error, then complete with nil then return from the function
            print("Unable to create base URL from : \(baseURLString)")
            completion(nil)
            return
        }
        // step 2- build out URL components
        baseURL.appendPathComponent("forecast")
        baseURL.appendPathComponent("daily")
        
        //step 3- building out Query parameters
        var urlComponents = (URLComponents(url: baseURL, resolvingAgainstBaseURL: true))
        //creating query items
        let keyQuery = URLQueryItem(name: "key", value: "ddae98f4e48d427f9c59a2ec2c5521c6")
        let postalQuery = URLQueryItem(name: "postal_code", value: "84074")
        let unitsQuery = URLQueryItem(name: "units", value: "I")
        let countryQuery = URLQueryItem(name: "country", value: "US")
        //adding our query items to our url
        urlComponents?.queryItems = [keyQuery, postalQuery, unitsQuery, countryQuery]
    
        //step 4- get our final url
        guard let finalURL = urlComponents?.url else {
            print("unable to create the final url from \(urlComponents?.description)")
            completion(nil)
            return
        }
        
        // step 5 -
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            // Step 6 - check for the error
            if let error = error {
                print(error)
                completion(nil)
            }
            
            //Step 7- chekcing for the data
            guard let data = data else {
                print("No data was found")
                completion(nil)
                return
            }
            
            //Step 8 - DeSerialize our data
            do {
                if let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                    // grab data from dictionary
                    guard let cityName = topLevelDictionary["city_name"] as? String,
                            let dataArray = topLevelDictionary["data"] as? [[String: Any]]
                    else {
                        print("Unable to decode data")
                        completion(nil)
                        return
                    }
                    //step 9 - pass data into optional init
                    var tempArray: [Day] = []
                    
                    for data in dataArray {
                        if let day = Day(dayDictionary: data, cityName: cityName) {
                            tempArray.append(day)
                        } else {
                            print("Failed to decode day: \(data)")
                        }
                    }
                    //step - 10 COmplete with our data
                    completion(tempArray)
                }
            } catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}// end of class
