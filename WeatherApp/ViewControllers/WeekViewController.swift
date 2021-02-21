//
//  WeekViewController.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import Foundation
import UIKit

class WeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var days: [Day] = []
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
                guard let days = weather?.daily?.data?[0..<7] else { return }
                self.days = Array(days)
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.infoView.type = .daily
        let day = days[indexPath.row]
        let temp = ((day.temperatureMin ?? 0) + (day.temperatureMax ?? 0)) / 2
        cell.infoView.setValues(time: day.time, summary: day.summary, temperature: temp, humidity: day.humidity, windSpeed: day.windSpeed)
        return cell
    }
}

