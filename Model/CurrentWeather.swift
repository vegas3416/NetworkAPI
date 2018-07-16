//
//  CurrentWeather.swift
//  NetworkAPI
//
//  Created by Jason Villegas on 7/15/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import Foundation


class CurrentWeather
{
	
	let temperature: Int?
	let humidity: Int?
	let precipProbability: Int?
	let summary: String?
	
	struct WeatherKeys {
		static let temperature = "temperature"
		static let humidity = "humidity"
		static let precipProbability = "precipProbability"
		static let summary = "summary"
	}
	
	init(weatherDictionairy: [String: Any]) {
		self.temperature = weatherDictionairy[WeatherKeys.temperature] as? Int
		if let humidityDouble = weatherDictionairy[WeatherKeys.humidity] as? Double {
			humidity = Int(humidityDouble * 100)
		} else {
			humidity = nil
		}
		if let precipDouble = weatherDictionairy[WeatherKeys.precipProbability] as? Double {
			precipProbability = Int(precipDouble * 100)
		} else {
			precipProbability = nil
		}
		
		self.summary = weatherDictionairy[WeatherKeys.summary] as? String
	}
	
}






