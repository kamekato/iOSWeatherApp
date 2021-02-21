//
//  HourlyViewController.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import Foundation
import UIKit

class HourlyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var hours: [Hour] = []
    var city: City?
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let city = city {
            Network.getWeather(city) { weather in
                guard let hours = weather?.hourly?.data?[0..<48] else { return }
                self.hours = Array(hours)
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.infoView.type = .hourly
        let hour = hours[indexPath.row]
        cell.infoView.setValues(time: hour.time, summary: hour.summary, temperature: hour.temperature, humidity: hour.humidity, windSpeed: hour.windSpeed)
        return cell
    }
}
