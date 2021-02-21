//
//  Models.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import Foundation

class WeatherResponse: Codable {
    var currently: Currently?
    var hourly: Hourly?
    var daily: Daily?
}

class Currently: Codable {
    var time: Double?
    var summary: String?
    var temperature: Double?
    var humidity: Double?
    var windSpeed: Double?
    
    enum CoingKeys: String, CodingKey {
        case time, summary, temperature, humidity, windSpeed
    }
}

class Hourly: Codable {
    var data: [Hour]?
    
    enum CoingKeys: String, CodingKey {
        case data
    }
}

class Hour: Codable {
    var time: Double?
    var summary: String?
    var temperature: Double?
    var humidity: Double?
    var windSpeed: Double?
    
    enum CoingKeys: String, CodingKey {
        case time, summary, temperature, humidity, windSpeed
    }
}

class Daily: Codable {
    var data: [Day]?
    
    enum CoingKeys: String, CodingKey {
        case data
    }
}

class Day: Codable {
    var time: Double?
    var summary: String?
    var temperatureMin: Double?
    var temperatureMax: Double?
    var humidity: Double?
    var windSpeed: Double?
    
    enum CoingKeys: String, CodingKey {
        case time, summary, temperatureMin, temperatureMax, humidity, windSpeed
    }
}
