//
//  Helper.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import Foundation
import Alamofire

enum City: String, CaseIterable {
    case tokyo = "Tokyo"
    case newYork = "New York"
    case mexicoCity = "Mexico City"
    case mumbai = "Mumbai"
    case losAngeles = "Los Angeles"
    
    var coordinates: (Double, Double) {
        switch self {
        case .tokyo:
            return (35.6897, 139.6922)
        case .newYork:
            return (40.6943, -73.9249)
        case .mexicoCity:
            return (19.4333, -99.1333)
        case .mumbai:
            return (18.9667, 72.8333)
        case .losAngeles:
            return (37.8267, -122.4233)
        }
    }
}

class Network {
    static func getWeather(_ city: City, completion: @escaping(_ model: WeatherResponse?)->()) {
        AF.request(URL(string: "https://api.darksky.net/forecast/4cb66a62816831e91d3d58d72a515f9a/\(city.coordinates.0),\(city.coordinates.1)")!, method: .get, parameters: ["units": "si"], encoding: URLEncoding(), headers: nil, interceptor: nil, requestModifier: nil).responseData() { response in
            guard let responseData = response.data else { return }
            do {
                let apiResponse = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                completion(apiResponse)
            } catch {
                completion(nil)
            }
        }
    }
}

class InfoView: UIStackView {
    var type: ViewType = .currently
    
    let timeLabel = UILabel()
    let summaryLabel = UILabel()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    let windSpeedLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        alignment = .fill
        distribution = .equalSpacing
        spacing = 10
        
        addArrangedSubview(timeLabel)
        addArrangedSubview(summaryLabel)
        addArrangedSubview(temperatureLabel)
        addArrangedSubview(humidityLabel)
        addArrangedSubview(windSpeedLabel)
    }
    
    func setValues(time: Double?, summary: String?, temperature: Double?, humidity: Double?, windSpeed: Double?) {
        guard let time = time, let temperature = temperature, let summary = summary, let humidity = humidity, let windSpeed = windSpeed else { return }
        let formatter = DateFormatter()
        switch type {
        case .currently:
            formatter.dateFormat = "dd MMMM YYYY"
        case .hourly:
            formatter.dateFormat = "HH:mm (dd MMMM)"
        case .daily:
            formatter.dateFormat = "dd MMMM"
        }
        self.timeLabel.text = formatter.string(from: Date(timeIntervalSince1970: time))
        self.summaryLabel.text = summary
        self.temperatureLabel.text = "Temperature: \(temperature) C"
        self.humidityLabel.text = "Humidity: \(Int(humidity*100))%"
        self.windSpeedLabel.text = "Wind speed: \(windSpeed) m/s"
    }
    
    enum ViewType {
        case currently
        case hourly
        case daily
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
