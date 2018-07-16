//
//  ForecastService.swift
//  NetworkAPI
//
//  Created by Jason Villegas on 7/15/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import Foundation

class ForecastService
{
	
	//Contain API key and Url
	let forecastAPIKEY: String
	let forecastBaseURL: URL?
	
	//forecastBaseURL/forecastAPIKEY/latitude,longitude
	
	init(APIKEY: String)
	{
		self.forecastAPIKEY = APIKEY
		forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(self.forecastAPIKEY)")
	}
	
	//completion is the data that comes back
	func getForecast(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void)
	{
		if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitude)")
		{
			let networkProcessor = NetworkProcessor(url: forecastURL)
			networkProcessor.downloadJSONFromURL { (jsonDictionairy) in
				
				if let currentWeatherDictionairy = jsonDictionairy?["currently"] as? [String: Any] {
					
					let currentWeather = CurrentWeather(weatherDictionairy: currentWeatherDictionairy)
					
					completion(currentWeather)
				} else {
					completion(nil)
				}
				
			}
		}
	}
	
	
}











