//
//  NetworkProcessor.swift
//  NetworkAPI
//
//  Created by Jason Villegas on 7/15/18.
//  Copyright © 2018 Jason Villegas. All rights reserved.
//

import Foundation


class NetworkProcessor
{
	lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
	lazy var session: URLSession = URLSession(configuration: self.configuration)
	
	let url: URL
	
	init(url: URL)
	{
		self.url = url
	}
	
	typealias JSONDictionairyHandler = (([String : Any]?) -> Void)
	
	func downloadJSONFromURL(_ completion: @escaping JSONDictionairyHandler)
	{
		let request = URLRequest(url: self.url)
		//This will be called after we get the data back
		let dataTask = session.dataTask(with: request) { (data, response, error) in
			
			//No error
			if error == nil {
				
				if let httpResponse = response as? HTTPURLResponse {
					switch httpResponse.statusCode {
					case 200:
						//success
						if let data = data {
							do {
								let jsonDictionairy = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
								
								completion(jsonDictionairy as? [String: Any])
								
							} catch let error as NSError {
								print("Error processing json data: \(error.localizedDescription)")
							}
							
						}
						
					default:
						print("HttpReponse code: \(httpResponse.statusCode)")
					}
				}
				
			} else {
				print("Error: \(String(describing: error?.localizedDescription))")
			}
		}
		
		//So this has to be called so that it finishes up..part of Apple stuff
		dataTask.resume()
	}
}









