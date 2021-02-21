//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Akan on 2/21/21.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class DetailViewController: UIViewController {
    var city: City?
    let infoView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(infoView)
        infoView.snp.makeConstraints({
            $0.top.left.right.equalToSuperview().inset(15)
        })
        
        if let city = city {
            Network.getWeather(city) { weather in
                self.infoView.setValues(time: weather?.currently?.time, summary: weather?.currently?.summary, temperature: weather?.currently?.temperature, humidity: weather?.currently?.humidity, windSpeed: weather?.currently?.windSpeed)
            }
        }
    }
}
