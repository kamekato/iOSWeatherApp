//
//  ViewController.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let cities = City.allCases
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cities"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Choose option", message: nil, preferredStyle: .actionSheet)
        let currentWeatherAction = UIAlertAction(title: "Current weather", style: .default, handler: { _ in
            let vc = DetailViewController()
            vc.title = "Current weather in \(self.cities[indexPath.row].rawValue)"
            vc.city = self.cities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        })
        let hoursAction = UIAlertAction(title: "Forecast for 48 hours", style: .default, handler: { _ in
            let vc = HourlyViewController()
            vc.title = "Forecast for 48 hours in \(self.cities[indexPath.row].rawValue)"
            vc.city = self.cities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        })
        let weekAction = UIAlertAction(title: "Forecast for a week", style: .default, handler: { _ in
            let vc = WeekViewController()
            vc.title = "Forecast for a week in \(self.cities[indexPath.row].rawValue)"
            vc.city = self.cities[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        })
        let closeAction = UIAlertAction(title: "Close", style: .destructive, handler: { _ in })
        alert.addAction(currentWeatherAction)
        alert.addAction(hoursAction)
        alert.addAction(weekAction)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
}

